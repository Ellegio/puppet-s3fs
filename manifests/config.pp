define s3fs::config( $bucket, $mountpoint, $options = 'allow_other,use_sse=1' ) {

  if !defined(File["$mountpoint"]) {
    file {"$mountpoint":
      ensure => directory,
    }
  }

  mount {"s3mount-$name":
    ensure   => mounted,
    device   => "s3fs#$bucket",
    name     => "$mountpoint",
    fstype   => 'fuse',
    options  => $options,
    remounts => false,
    require  => [ Class['s3fs'], File["$mountpoint"], ],
  }

}
