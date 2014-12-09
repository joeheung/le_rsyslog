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
  notifies  :restart, "service[rsyslog]", :delayed
end
