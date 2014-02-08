#
# Cookbook Name:: shi_mysql
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
PACKAGES = [
  "mysql-server"
].each { |package|
  package "#{package}" do
    action :install
  end
}

CONF_DIR = node[:shi_mysql][:Server][:ConfDir]
CONFIGS = [
  "my.cnf"
].each { |config|
  template "#{CONF_DIR}/#{config}" do
    source "#{config}.erb"
    mode   "0644"
    action :create
  end

  service "mysql" do
    action     :nothing
    subscribes :restart, "template[#{CONF_DIR}/#{config}]", :immediately
  end
}

ROOT_NAME   = node[:shi_mysql][:Server][:Root][:Name]
ROOT_PASSWD = node[:shi_mysql][:Server][:Root][:Passwd]
bash "Set Root Password" do
  code   <<-EOH
    mysqladmin -u #{ROOT_NAME} password #{ROOT_PASSWD}
  EOH
  action :run
  not_if "mysql -u#{ROOT_NAME} -p#{ROOT_PASSWD}"
end

