#
# Cookbook Name:: shi_nise_bosh
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
INSTALL_DIR = node[:shi_nise_bosh][:InstallDir]
REPOSITORY  = node[:shi_nise_bosh][:Repository]
NBOSH_ROOT  = "#{INSTALL_DIR}/nise_bosh"

include_recipe "shi_ruby"

DEPENDS_PACKAGE = [
  "libxslt-dev",
  "libxml2-dev",
  "git-core",
  "g++"
].each { |package|
  package "#{package}" do
    action :install
  end
}

RUBY_PACKAGES = [
  "bundler"
].each { |package|
  gem_package "#{package}" do
    action :install
  end
}

git "#{NBOSH_ROOT}" do
  repository "#{REPOSITORY}"
  action     :sync
end

bash "install nise_bosh" do
  cwd    "#{NBOSH_ROOT}"
  code   <<-EOH
    bundle install
  EOH
  action :run
end
