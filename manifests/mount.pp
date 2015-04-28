# autofs::mount is used to create a mount entry in a map file.

define autofs::mount ($device, $options, $mapfile = $autofs::params::master) {
  include autofs
  include autofs::params

  # We can use the autofs::mapfile type to ensure that an
  # appropriate map file has been created.  If one already
  # exists it will do nothing.
  autofs::mapfile { "autofs::mount ${title}": path => "/etc/autofs/${mapfile}", }

  # This fragment will be concatenated into the target file
  # to provide a mount entry.  We use the title (of the mount
  # object) as the mount path.
  concat::fragment { "autofs::mount ${mapfile}:${title}":
    target  => "/etc/autofs/${mapfile}",
    content => "${title} -${options} ${device}\n",
    order   => '200',
  }
}
