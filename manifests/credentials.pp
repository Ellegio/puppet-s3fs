class s3fs::credentials (
  $accesskey = $::s3fs::params::accesskey,
  $secretkey = $::s3fs::params::secretkey,
  $user      = $::s3fs::params::user,
  $group     = $::s3fs::params::group,
) inherits s3fs::params {
  if $accesskey and $secretkey {
    file { '/etc/.passwd-s3fs':
      ensure  => present,
      owner   => $user,
      group   => $group,
      mode    => '600',
      content => template("s3fs/passwd-s3fs"),
    }
  }
}
