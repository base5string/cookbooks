#
# Cookbook Name:: shi_mysql
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
if node[:shi_mysql][:ReplicaSets] != nil then
  include_recipe "shi_mysql::deploy_replica"
else
  include_recipe "shi_mysql::deploy_server"
end

