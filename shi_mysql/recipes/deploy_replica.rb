#
# Cookbook Name:: shi_mysql
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
node[:shi_mysql][:ReplicaSets].each { |replica_set|
  if replica_set[:Master][:Host] == node[:hostname] then
    node.set[:shi_mysql][:Server][:Port]     = replica_set[:Master][:Port]
    node.set[:shi_mysql][:Server][:ServerId] = replica_set[:Master][:ServerId]

    include_recipe "shi_mysql::deploy_replica"
  end
}

