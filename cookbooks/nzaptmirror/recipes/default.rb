include_recipe "apt"
 
template "/etc/apt/sources.list" do
  mode 0644
  variables :code_name => node[:lsb][:codename]
  notifies :run, resources(:execute => "apt-get update"), :immediately
  source "sources.list.erb"
end
