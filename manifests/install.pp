# == Class: skype::install
#
# Install Skype for Debian 64-Bit
#
# === Authors
#
# Niklaus Giger <niklaus.giger@member.fsf.org>
#
# === Copyright
#
# Copyright 2013 Niklaus Giger.
#
class skype::install {

  $package = $skype::params::package
  $source  = $skype::params::source
  $version = $skype::params::version

  $deb_file = "/var/cache/skype-$version.deb"
  ensure_packages(['wget', 'gdebi-core'])

  exec { "$deb_file":
    command => "wget --timestamping $source --output-document=$deb_file",
    require => [Package['wget'] ],
    path    => '/usr/bin:/bin',
    timeout => 600, # allow maximal 10 minutes for download
    creates => "$deb_file";
  }
  if ($::hardwaremodel == 'x86_64' and $::lsbdistcodename == 'wheezy') {
      exec {'add-i386':
          command => '/usr/bin/dpkg --add-architecture i386 && /usr/bin/apt-get update',
          unless  => '/usr/bin/dpkg --print-foreign-architectures |
                        /bin/grep i386',
      }
      package{'libqtwebkit4:i386':
        ensure => present,
        require =>  Exec["$deb_file"],
      }
     
      exec {"gdebi-$deb_file":
          command => "gdebi --non-interactive $deb_file",
          path    => '/usr/bin:/bin:/usr/sbin:/sbin',
          unless  => '/usr/bin/dpkg -l "*skype*" | grep ii',
          require => Package['libqtwebkit4:i386'],
      }
  } 
  package {"skype":
    ensure => installed,
    source => $deb_file,
    provider => dpkg,
    require  => Exec["$deb_file", "gdebi-$deb_file"],
  }

}