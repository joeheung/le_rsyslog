service 'rsyslog' do
  supports :start => true, :stop => true, :restart => true, :status => true
  action :nothing
end

# TODO: uncomment when SSL support added to config template
# if node['le_rsyslog']['forwarder']['ssl']
#   include_recipe 'le_rsyslog::ssl_support'
# end

template '/etc/rsyslog.d/6-logentries-token-forward.conf' do
  source 'token_forwarder.conf.erb'
  owner 'root'
  group 'root'
  mode '0644'
  variables({
    listener: node['le_rsyslog']['listener'],
    tokenizer: node['le_rsyslog']['tokenizer'],
    forwarder: node['le_rsyslog']['forwarder']
  })
  notifies :restart, 'service[rsyslog]', :delayed
end


account_key = node['le_rsyslog']['tokenizer_rb']['account_key']
if account_key.nil? || account_key.empty?
  raise Chef::Exceptions::ValidationFailed, 'YOU MUST SET node.le_rsyslog.tokenizer_rb.account_key !!!!!!'
end

# dangerously validate our attributes -- but if we can't trust them we're
# screwed already
regex = eval(node['le_rsyslog']['tokenizer_rb']['match_regex'])
unless regex.class == Regexp
  raise Chef::Exceptions::ValidationFailed, 'node.le_rsyslog.tokenizer_rb.match_regex must be a valid ruby regex expression (do you need to wrap in slashes?)'
end
unless regex.named_captures["host"] and regex.named_captures["log"]
  raise Chef::Exceptions::ValidationFailed 'node.le_rsyslog.tokenizer_rb.match_regex must contain named captures for host and log e.g. (?<host>\w+)'
end

capture_binding = binding
regex.named_captures.keys.each do |name|
  capture_binding.local_variable_set(name.to_sym, "foo")
end
begin
  capture_binding.eval(node['le_rsyslog']['tokenizer_rb']['validate_expression'])
rescue Exception => e
 raise Chef::Exceptions::ValidationFailed, "node.le_rsyslog.tokenizer_rb.validate_expression must be a valid ruby expression.\nFailed with: #{e}"
end

template node['le_rsyslog']['tokenizer']['path'] do
  source 'tokenizer.rb.erb'
  owner 'root'
  group 'root'
  mode '0755'
  variables(
    node['le_rsyslog']['tokenizer_rb'].dup.tap do |h|
      h['log_path'] = node['le_rsyslog']['tokenizer']['log_path']
      h['forwarder'] = node['le_rsyslog']['forwarder']
    end
  )
end

#TODO?: set owner to syslog user and mode to owner-only write
file node['le_rsyslog']['tokenizer']['log_path'] do
  action :create_if_missing
  mode '0666'
end
