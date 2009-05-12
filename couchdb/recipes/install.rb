#
# Cookbook Name:: couchdb
# Recipe:: install
# Notes: This currently only works on ubuntu 9+ support for previous
#        versions forthcoming
# Author: James Carr
# 
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#     http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
#

case node[:platform]
when "debian", "ubuntu"
  %w{libmozjs-dev libicu-dev libcurl4-openssl-dev erlang}.each {|pkg| package(pkg) }
end  

execute "download_couchdb" do
  user "root"
  cwd "/tmp"
  command "wget http://mirrors.24-7-solutions.net/pub/apache/couchdb/0.9.0/apache-couchdb-0.9.0.tar.gz"
  creates "/tmp/apache-couchdb-0.9.0.tar.gz"
  action :run
end

script "install_couchdb" do
  interpreter "bash"
  user "root"
  cwd "/tmp"
  code <<-EOH    
    tar zxvf apache-couchdb-0.9.0.tar.gz  
    cd apache-couchdb-0.9.0  
    ./configure && make && make install
  EOH
end
