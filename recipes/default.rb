#
# Cookbook Name:: le_rsyslog
# Recipe:: default
#
# Copyright (C) 2014 Joe Heung
#
# All rights reserved - Do Not Redistribute
#

service 'rsyslog' do
  supports :start => true, :stop => true, :restart => true, :status => true
  action :nothing
end

template '/etc/rsyslog.d/5-logentries.conf' do
  source 'logentries.conf.erb'
  owner     'root'
  group     'root'
  mode      '0644'
  notifies  :restart, 'service[rsyslog]', :delayed
end

if node['le_rsyslog']['logentries']['ssl']
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
end