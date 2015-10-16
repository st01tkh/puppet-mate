# == Class: mate
#
# Installs MATE Desktop on Ubuntu Trusty (for now)
#
# === Parameters
#
# === Variables
#
# === Examples
#
#  class { mate:
#  }
#
# === Authors
#
# st01tkh <st01tkh@gmail.com>
#
# === Copyright
#
# Copyright 2015 st01tkh
# 
#
class mate {
  case $operatingsystem {
  'Solaris':          {
    notify {'No action for Solaris yet':}
  }
  'RedHat', 'CentOS': {
    notify {'No action for RedHat and/or CentOS yet':} 
  }
  /^(Ubuntu)$/:{
    case $lsbdistcodename {
    'precise': {
    }
    'trusty': {
        exec {"add_ubuntu_mate_dev_ppa_repo":
          command => "add-apt-repository -y ppa:ubuntu-mate-dev/ppa",
          path => [ '/bin', '/sbin', '/usr/bin', '/usr/sbin', '/usr/local/bin', '/usr/local/sbin' ]
        }
        exec {"add_ubuntu_mate_dev_trusty_ppa_repo":
          command => "add-apt-repository -y ppa:ubuntu-mate-dev/trusty-mate",
          path => [ '/bin', '/sbin', '/usr/bin', '/usr/sbin', '/usr/local/bin', '/usr/local/sbin' ]
        }
        exec {"update_by_mate_repos":
          command => "apt-get -y update",
          path => [ '/bin', '/sbin', '/usr/bin', '/usr/sbin', '/usr/local/bin', '/usr/local/sbin' ]
        }
        exec {"upgrade_by_mate_repos":
          command => "apt-get -y upgrade",
          path => [ '/bin', '/sbin', '/usr/bin', '/usr/sbin', '/usr/local/bin', '/usr/local/sbin' ]
        }
        package {"modemmanager":
          ensure => 'installed',
        }
        package {"ubuntu-mate-core":
          ensure => 'installed',
        }
        package {"ubuntu-mate-desktop":
          ensure => 'installed',
        }

        Exec["add_ubuntu_mate_dev_ppa_repo"]->
        Exec["add_ubuntu_mate_dev_trusty_ppa_repo"]->
        Exec["update_by_mate_repos"]->
        Exec["upgrade_by_mate_repos"]->
        Package["modemmanager"]->
        Package["ubuntu-mate-core"]->
        Package["ubuntu-mate-desktop"]
    }
    }
  }
  /^(Debian)$/:{
    notify {'No action for Debian yet':}
  }
  default: {
    notify {'No action by default':}
  }
  }

}
