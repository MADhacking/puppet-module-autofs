# autofs::include is used to create an include directive in the
# master map file for the named map file.  It also ensures
# that the named map file exists (using autofs::mapfile).

define autofs::include($mount_base, $options)
{
	include autofs
	include autofs::params

	# Ensure that we have at least a blank sub map file.
	autofs::mapfile
	{
		"autofs::include ${title}":
		    path => "/etc/autofs/${title}",
	}

	# Add an include line to the master map file for this sub map file.
	concat::fragment
	{
		"autofs::include ${title}":
		    target  => $autofs::params::master,
		    content => "${mount_base} /etc/autofs/${title} ${options}\n",
		    order   => '200',
	}
}
