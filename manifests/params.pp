class autofs::params
{
    # File ownership settings.
    $group   = 'root'
    $owner   = 'root'
    
    # The name of the service.
    $service = 'autofs'

    # These settings are OS specific.
    case $::operatingsystem
	{
	    'Gentoo': 
	    {
			$package    = [ 'net-fs/autofs' ]
			$master     = '/etc/autofs/auto.master'
			$master_dir = true
			$confd		= '/etc/conf.d/autofs'
	    }
	    'Debian': 
	    {
			$package    = [ 'autofs', 'autofs-ldap' ]
			$master     = '/etc/auto.master'
            $master_dir = false
			$confd		= undef
	    }
	    'Solaris': 
	    {
			$package    = [] # solaris has it built-in, no package required
			$master     = '/etc/auto_master'
            $master_dir = false
			$confd		= undef
	    }
	    'RedHat': 
	    {
			$package    = [ 'autofs' ]
			$master     = '/etc/auto.master'
            $master_dir = false
			$confd		= undef
	    }
	    default:
	    {
	    	fail("$::operatingsystem not supported!")
	    }
	}
}
