default['le_rsyslog']['logentries']['logs'] =
    [ {:name => 'alpha', :log => '/var/log/alpha', :token => 'logentries_token'},
      {:name => 'beta', :log => '/var/log/beta', :token => 'logentries_token'} ]

default['le_rsyslog']['logentries']['ssl'] = true
default['le_rsyslog']['logentries']['ssl_dir'] = '/opt/ssl'
