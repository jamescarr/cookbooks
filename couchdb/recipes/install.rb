%w{"libmozjs-dev", "libicu-dev", "libcurl4-openssl-dev", "erlang"}.each {|pkg| package(pkg) }

script "install_couchdb" do
  interpreter "bash"
  user "root"
  cwd "/tmp"
  code <<-EOH
    wget http://mirrors.24-7-solutions.net/pub/apache/couchdb/0.9.0/apache-couchdb-0.9.0.tar.gz  
    tar zxvf apache-couchdb-0.9.0.tar.gz  
    cd apache-couchdb-0.9.0  
    ./configure && make && sudo make install
  EOH
end
  

