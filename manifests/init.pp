# firefox
#
# This class installs firefox
#
# Parameters:
#  - version: the version of firefox to install (Default: 'firefox-l10n-en-us')
#  - removeiceweasel: removes iceweasel if set to true (Default: true)
#  - ensure: the ensure for the package (Default: 'latest')

# Sample Usage:
#  ::firefox{"firefox":
#  }
#
define firefox(
	$version='firefox-mozilla-build',
	$removeiceweasel=true,
	$ensure='latest'
) {
	case $::operatingsystem {
		'centos', 'redhat', 'fedora': {
			#TODO: Needs filling out
		}
		'ubuntu', 'debian': {
			apt::source {'firefoxsource':
			  name => 'downloads-sourceforge-net_project_ubuntuzilla_mozilla_apt',
				location    => 'http://downloads.sourceforge.net/project/ubuntuzilla/mozilla/apt',
				release     => ' ',
				repos       => 'all main',
				key        => 'C1289A29',
  			key_server => 'keyserver.ubuntu.com',
				include_src => false
			}

		}
		default: {
			apt::source {'firefoxsource':
        name => 'downloads-sourceforge-net_project_ubuntuzilla_mozilla_apt',
        location    => 'http://downloads.sourceforge.net/project/ubuntuzilla/mozilla/apt',
        release     => ' ',
        repos       => 'all main',
        key        => 'C1289A29',
        key_server => 'keyserver.ubuntu.com',
        include_src => false
      }
		}
	}
	
	if $removeiceweasel == true {
		package{"removeiceweasel":
			name=>"iceweasel",
			ensure=>"purged"
		}
	}
	
	package{"installfirefox":
		name=>$version,
		ensure=>$ensure,
		require=>Apt::Source['firefoxsource']
	}
}
