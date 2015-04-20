define autofs::include($mountpoint, $options)
{
	include autofs
	include autofs::params

	autofs::mapfile
	{
		"autofs::include ${title}":
		path => "/etc/autofs/${title}",
	}
	
	concat::fragment
	{
		"autofs::include ${title}":
		target  => $autofs::params::master,
		content => "${mountpoint} /etc/autofs/${title} ${options}\n",
		order   => '200',
	}
}
