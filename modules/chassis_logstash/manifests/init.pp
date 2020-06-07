class chassis_logstash (
	$config
) {
	if ( ! empty( $config[disabled_extensions] ) and 'chassis/chassis_logstash' in $config[disabled_extensions] ) {
		class { 'logstash':
			ensure => absent
		}
		class { 'java-common':
			ensure => absent
		}
	} else {
		$defaults = {
			'repo_version' => '7',
			'version'      =>  latest,
			# Ensure Java doesn't try to eat all the RAMs by default
			'memory'       => 256,
			'jvm_options'  => [],
		}

		include ::java

		# Allow override from config.yaml
		$options = deep_merge($defaults, $config[logstash])

		# Ensure memory is an integer
		$memory = Integer($options[memory])

		# Create default jvm_options using memory setting
		$jvm_options_defaults = [
			"-Xms${memory}m",
			"-Xmx${memory}m",
			'#UseParNewGC',
			'#UseConcMarkSweepGC'
		]

		# Merge JVM options using our custom function
		$jvm_options = merge_jvm_options($options[jvm_options], $jvm_options_defaults)

		if ! defined(Class['Elastic_stack::Repo']) {
				class { 'elastic_stack::repo':
				version => Integer($options[repo_version]),
				notify => Exec['apt_update']
			}
		}

		class { 'logstash':
			version     => $options[version],
			ensure      => present,
			require     => Class['java'],
			jvm_options => $jvm_options,
		}

		logstash::configfile { 'syslog_config':
			content => template('chassis_logstash/logstash-syslog.conf.erb')
		}
	}
}
