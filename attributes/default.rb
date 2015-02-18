default['le_rsyslog']['logentries']['logs'] =
    [ {:name => 'alpha', :log => '/var/log/alpha', :token => 'logentries_token'},
      {:name => 'beta', :log => '/var/log/beta', :token => 'logentries_token'} ]

default['le_rsyslog']['logentries']['ssl'] = true
default['le_rsyslog']['logentries']['ssl_dir'] = '/opt/ssl'

default['le_rsyslog']['datahub']['enabled'] = false
default['le_rsyslog']['datahub']['ip'] = '127.0.0.1'
default['le_rsyslog']['datahub']['port'] = 10000
