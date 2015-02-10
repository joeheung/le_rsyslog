#we want to masquerade as a datahub, as a rule
default['le_rsyslog']['listener']['port'] = '10000'

default['le_rsyslog']['tokenizer']['path'] = '/usr/local/bin/logentries_tokenizer'
default['le_rsyslog']['tokenizer']['log_path'] = '/var/log/logentries_tokenizer.log'

default['le_rsyslog']['tokenizer']['input_template'] = 'RSYSLOG_TraditionalFileFormat'

default['le_rsyslog']['tokenizer_rb']['interpreter'] = RbConfig.ruby #use Chef's ruby in case there aren't any others
default['le_rsyslog']['tokenizer_rb']['account_key'] = ''
default['le_rsyslog']['tokenizer_rb']['log_level'] = 'INFO'
default['le_rsyslog']['tokenizer_rb']['match_regex'] = '/^.*? (?<host>[a-z][a-z0-9-]+) (?<log>[\w\.]+?) (?<line>.*$)/'
default['le_rsyslog']['tokenizer_rb']['validate_expression'] = 'host.nil? || log.nil? || host.empty? || log.empty?'
default['le_rsyslog']['tokenizer_rb']['emit_string'] = '"#{token} #{line}\n"'

default['le_rsyslog']['forwarder']['host'] = '127.0.0.1'
default['le_rsyslog']['forwarder']['port'] = '10001'
default['le_rsyslog']['forwarder']['ssl'] = false
default['le_rsyslog']['forwarder']['ssl_dir'] = '/opt/ssl'

