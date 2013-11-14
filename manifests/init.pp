# == Class: skype
#
# Install Skype for Debian 64-Bit
#
# === Parameters:
#
# [*version*] Version of Skype
#
# === Authors
#
# Niklaus Giger <niklaus.giger@member.fsf.org>
#
# === Copyright
#
# Copyright 2013 Niklaus Giger.
#
class skype(
  $version = $skype::params::version
) inherits skype::params {

  anchor {'skype::begin': } ->
  class {'skype::install': } ->
  anchor {'skype::end': }

}