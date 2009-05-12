

case node[:platform]
when "debian", "ubuntu"
  %w{libmozjs-dev libicu-dev libcurl4-openssl-dev}.each {|pkg| package(pkg) }
end  

execute "download_erlang" do
  user "root"
  cwd "/tmp"
  command "wget http://erlang.org/download/otp_src_R13B.tar.gz"
  creates "/tmp/otp_src_R13B.tar.gz"
  action :run
end

execute "download_couchdb" do
  user "root"
  cwd "/tmp"
  command "wget http://mirrors.24-7-solutions.net/pub/apache/couchdb/0.9.0/apache-couchdb-0.9.0.tar.gz"
  creates "/tmp/apache-couchdb-0.9.0.tar.gz"
  action :run
  not_if "test -f /usr/bin/erl"
end


script "install_erlang" do
  interpreter "bash"
  user "root"
  cwd "/tmp"
  code <<-EOH  
    tar zxvf otp_src_R13B.tar.gz
    cd otp_src_R13B
    ./configure && make && make install
  EOH
  not_if "test -f /usr/bin/erl"
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
