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
			'version'      =>  '1:7.6.2-1'
		}

		include ::java

		# Allow override from config.yaml
		$options = deep_merge($defaults, $config[logstash])

		class { 'elastic_stack::repo':
			version => Integer($options[repo_version]),
			notify  => Exec['apt_update']
		}

		class { 'logstash':
			version => $options[version],
			ensure  => present,
			require => Class['java']
		}
	}
}
