#
# Cookbook Name:: shi_ruby
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
MEDIA_URL   =  node[:shi_ruby][:MediaURL]
MEDIA_URL   =~ /([^\/]+?)([\?#].*)?$/
MEDIA_NAME  =  $&
MEDIA_BASE  =  File.basename(MEDIA_NAME, ".tar.gz")
INSTALL_DIR =  node[:shi_ruby][:InstallDir]
DST_PATH    =  "#{INSTALL_DIR}/#{MEDIA_NAME}"
RUBY_ROOT   =  "#{INSTALL_DIR}/#{MEDIA_BASE}"

DEPENDS_PACKAGES = [
  "zlib1g-dev",
  "libssl-dev"
].each { |package|
  package "#{package}" do
    action :install
  end
}

remote_file "#{MEDIA_URL}" do
  source "#{MEDIA_URL}"
  path   "#{DST_PATH}"
  mode   "0644"
  action :create
  not_if {File.exists?("#{RUBY_ROOT}")}
end

bash "Expand #{MEDIA_URL}" do
  cwd        "#{INSTALL_DIR}"
  code       <<-EOH
    tar zxvf ./#{MEDIA_NAME}
    rm -rf ./#{MEDIA_NAME}
  EOH
  action     :nothing
  subscribes :run, "remote_file[#{MEDIA_URL}]", :immediately
end

bash "Install #{MEDIA_URL}" do
  cwd        "#{RUBY_ROOT}"
  code       <<-EOH
    ./configure
    make install
  EOH
  action     :nothing
  subscribes :run, "bash[Expand #{MEDIA_URL}]", :immediately
end

bash "Enable OpenSSL" do
  cwd        "#{RUBY_ROOT}/ext/openssl"
  code       <<-EOH
    ruby ./extconf.rb
    make install
  EOH
  action     :nothing
  subscribes :run, "bash[Install #{MEDIA_URL}]", :immediately
end

