class s3fs::params {

  case $::operatingsystem {
    'CentOS', 'Fedora', 'Scientific', 'RedHat', 'Amazon': {
      $dependency_pkgs = [
        'gcc',
        'libstdc++-devel',
        'gcc-c++',
        'libcurl-devel',
        'libxml2-devel',
        'openssl-devel',
        'mailcap',
        'automake',
      ]
      $conflict_pkgs = [
        'fuse',
        'fuse-devel',
        'fuse-s3fs',
      ]
    }
    'Debian', 'Ubuntu': {
      fail("\"${module_name}\" provides no support yet
            for \"${::operatingsystem}\"")
    }
    default: {
      fail("\"${module_name}\" provides no support
            for \"${::operatingsystem}\"")
    }
  }

  $s3_mount = hiera('s3_mount','')

  $user = $s3_mount[1]['user']
  $group = $s3_mount[1]['group']
  $accesskey = $s3_mount[1]['accesskey']
  $secretkey = $s3_mount[1]['secretkey']
  $bucket_name = $s3_mount[1]['bucket_name']
  $mountpoint = $s3_mount[1]['mountpoint']
  $s3fs_version = '1.80'
  $tarball_url = 'https://github.com/s3fs-fuse/s3fs-fuse/archive'
  $fuse_url = 'https://github.com/libfuse/libfuse/releases/download/fuse-2.9.7'
  $fuse_version = '2.9.7'
  $tarball_dir = '/usr/local/src'
  $options = 'passwd_file=/etc/.passwd-s3fs,allow_other,use_sse=1'
}
