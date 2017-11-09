class s3fs (
  $s3fs_version    = $::s3fs::params::s3fs_version,
  $fuse_version    = $::s3fs::params::fuse_version,
  $tarball_url     = $::s3fs::params::tarball_url,
  $fuse_url        = $::s3fs::params::fuse_url,
  $tarball_dir     = $::s3fs::params::tarball_dir,
  $fuse_pkg        = $::s3fs::params::fuse_pkg,
  $s3fs_pkg        = $::s3fs::params::s3_pkg,
  $dependency_pkgs = $::s3fs::params::dependency_pkgs,
  $conflict_pkgs   = $::s3fs::params::conflict_pkgs,
  $accesskey       = $::s3fs::params::accesskey,
  $secretkey       = $::s3fs::params::secretkey,
  $bucket_name     = $::s3fs::params::bucket_name,
  $user            = $::s3fs::params::user,
  $group           = $::s3fs::params::group,
  $mountpoint      = $::s3fs::params::mountpoint,
) inherits s3fs::params {


  anchor { '::s3fs::begin': } ->
  class { '::s3fs::params': } ->
  class { '::s3fs::dependencies': } ->
  class { '::s3fs::fuse': } ->
  class { '::s3fs::install': } ->
  anchor { '::s3fs::end': } ->
  class { 's3fs::credentials': } ->
  s3fs::config { $bucket_name:
    bucket     => $bucket_name,
    mountpoint => $mountpoint,
  }

}
