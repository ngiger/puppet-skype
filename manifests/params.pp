# == Class: skype::params
#
# Define default parameters.
#
# === Authors
#
# Niklaus Giger <niklaus.giger@member.fsf.org>
#
# === Copyright
#
# Copyright 2013 Niklaus Giger.
#
class skype::params {

  $mode = 'skype'
  $version = '4.2.0.11-1'
  $source = $::kernel ? {
    'Linux' => downcase("http://download.skype.com/linux/skype-${::operatingsystem}_${version}_i386.deb"),
    default => fail("Unsupported Kernel: ${::kernel} Operating System: ${::operatingsystem}")
  }
# dpkg --add-architecture i386
}

# required:  http://download.skype.com/linux/skype-debian_4.1.0.20-1_i386.deb
#             http://download.skype.com/linux/skype-debian_4.2.0.11-1_i386.deb
# is         http://download.skype.com/linux/skype-Debian_4.2.0.11-1_i386.deb
# http://www.sysadminslife.com/linux/howto-oracle-sun-java-7-installation-unter-debian-6-squeeze/