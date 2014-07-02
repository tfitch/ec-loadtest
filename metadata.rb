name             'ec-loadtest'
maintainer       'Tyler Fitch'
maintainer_email 'tfitch@getchef.com'
license          'Apache 2.0'
description      'Installs/Configures ec-loadtest'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

# Tested on Ubuntu 14.04
supports 'ubuntu'

depends 'jenkins'
depends 'hostsfile'