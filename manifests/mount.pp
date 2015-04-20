define autofs::mount($device, $options, $mapfile)
{
	include autofs
	include autofs::params

	autofs::mapfile
	{
		"autofs::mount ${title}":
		path => "/etc/autofs/${mapfile}",
	}

	concat::fragment
	{
		"autofs::mount ${mapfile}:${title}":
		target  => "/etc/autofs/${mapfile}",
		content => "${title} -${options} ${device}\n",
		order   => '200',
	}
}
