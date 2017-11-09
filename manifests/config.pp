define s3fs::config (
  $bucket,
  $mountpoint,
) {

  if !defined(File["$mountpoint"]) {
    $path_parents = all_parents($mountpoint)
    file { $path_parents:
      ensure => 'directory',
      owner  => $user,
      group  => $group,
    }
    file { $mountpoint:
      ensure => 'directory',
      owner  => $user,
      group  => $group,
    }
  }

  mount { "s3mount-$name":
    ensure   => mounted,
    device   => "s3fs#$bucket",
    name     => "$mountpoint",
    fstype   => 'fuse',
    options  => $options,
    remounts => false,
    require  => [ Class['s3fs'], File["$mountpoint"], ],
  }

}
