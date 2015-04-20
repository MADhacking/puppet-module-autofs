class autofs
{
	include autofs::params

	package
	{
		$autofs::params::package:
			ensure => installed,
			notify => Service[$autofs::params::service],
	}

	service
	{
		$autofs::params::service:
			ensure  	=> running,
			enable  	=> true,
			require 	=> Package[$autofs::params::package],
			subscribe 	=> File['autofs.confd']
	}
	
	file
	{
		'autofs.confd':
			path 	=> $autofs::params::confd,
			ensure 	=> file,
			require => Package[$autofs::params::package],
			source	=> "puppet:///modules/autofs/autofs.confd"
	}
	
	file
	{
		'/etc/auto.master':
		ensure => 'absent'
	}
	
	file
	{
		'/etc/auto.misc':
		ensure => 'absent'
	}
	
	autofs::mapfile
	{
		"autofs::master":
		path => "$autofs::params::master",
	}
}
