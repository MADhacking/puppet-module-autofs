class autofs::params
{
	#case $::osfamily
	#{
	#	'Linux':
	#	{
			case $::operatingsystem
			{
			    'Gentoo': 
			    {
					$package    = [ 'net-fs/autofs' ]
					$service    = 'autofs'
					$master     = '/etc/autofs/auto.master'
					$group      = 'root'
					$owner      = 'root'
					$confd		= '/etc/conf.d/autofs'
			    }
			    'Debian': 
			    {
					$package    = [ 'autofs', 'autofs-ldap' ]
					$service    = 'autofs'
					$master     = '/etc/auto.master'
					$group      = 'root'
					$owner      = 'root'
					$confd		= undef
			    }
			    'Solaris': 
			    {
					$package    = [] # solaris has it built-in, no package required
					$service    = 'autofs'
					$master     = '/etc/auto_master'
					$owner      = 'root'
					$group      = 'root'
					$confd		= undef
			    }
			    'RedHat': 
			    {
					$package    = [ 'autofs' ]
					$service    = 'autofs'
					$master     = '/etc/auto.master'
					$owner      = 'root'
					$group      = 'root'
					$confd		= undef
			    }
			    default:
			    {
			    	fail("$::operatingsystem not supported!")
			    }
			}
	#    }
	#	default:
	#	{
	#		fail("$::osfamily not supported!")
	#	}
	#}
}
