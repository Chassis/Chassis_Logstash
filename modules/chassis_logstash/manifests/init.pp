class chassis_logstash (
	$config
) {
	if ( ! empty( $config[disabled_extensions] ) and 'chassis/chassis_logstash' in $config[disabled_extensions] ) {
		$package = absent
	} else {
		$package = latest
	}
	$defaults = {
		'repo_version' => '7',
		'version'      =>  'latest'
	}

	# Allow override from config.yaml
	$options = deep_merge($defaults, $config[logstash])

	class { 'elastic_stack::repo':
		version => Integer($options[repo_version]),
		notify  => Exec['apt_update']
	}

	class { 'logstash':
		version => $options[version],
		ensure  => $package
	}
}
