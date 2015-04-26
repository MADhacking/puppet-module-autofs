class autofs
{
	include autofs::params

	# Ensure that the required package is installed.
	package
	{
		$autofs::params::package:
			ensure => installed,
			notify => Service[$autofs::params::service],
	}

	# Ensure that the required service is started.
	service
	{
		$autofs::params::service:
			ensure  	=> running,
			enable  	=> true,
			require 	=> Package[$autofs::params::package],
	}

	# If the OS we are on has a conf.d file we need to create it
	# and set notify to restart the service when it changes.  
	if $autofs::params::confd
	{
    	file
    	{
    		'autofs.confd':
    			path 	=> $autofs::params::confd,
    			ensure 	=> file,
    			require => Package[$autofs::params::package],
    			source	=> "puppet:///modules/autofs/autofs.confd",
    			notify  => Service[$autofs::params::service],
    	}
	}
	
	# If the OS we are on has a separate dir for the autofs.* files
	# then we need to remove any created in an incorrect location.
	if $autofs::params::master_dir
	{
    	file { '/etc/auto.master': ensure => 'absent' }
    	file { '/etc/auto.misc': ensure => 'absent'	}
	}
	
	# Declare a master map file (empty by default). 
	autofs::mapfile	{ "autofs::master":	path => "$autofs::params::master", }
}
