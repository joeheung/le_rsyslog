package 'rsyslog-gnutls'

directory node['le_rsyslog']['logentries']['ssl_dir'] do
  owner 'root'
  group 'root'
  mode '0755'
  recursive true
  action :create
end

cookbook_file 'data.logentries.cert' do
  path File.join(node['le_rsyslog']['logentries']['ssl_dir'], 'data.logentries.cert')
  action :create_if_missing
end
