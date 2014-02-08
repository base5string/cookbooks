#
# Cookbook Name:: shi_cf
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
include_recipe "shi_bosh_cli"
include_recipe "shi_nise_bosh"

REPOSITORY  = node[:shi_cf][:Repository]
INSTALL_DIR = node[:shi_cf][:InstallDir]
CF_ROOT     = "#{INSTALL_DIR}/cf-release"

git "#{CF_ROOT}" do
  repository "#{REPOSITORY}"
  action     :sync
end

bash "Update Release" do
  cwd    "#{CF_ROOT}"
  code   <<-EOH
    ./update
  EOH
  action :run
end

