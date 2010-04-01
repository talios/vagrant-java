#
# Cookbook Name:: java
# Recipe:: default
#
# Copyright 2008-2009, Opscode, Inc.
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

java_pkg = value_for_platform(
  "ubuntu" => {
    "default" => "sun-java6-jdk"
  },
  "debian" => {
    "default" => "sun-java6-jdk"
  },
  "default" => "sun-java6-jdk"
)

execute "update-java-alternatives" do
  command "update-java-alternatives -s java-6-sun"
  only_if do platform?("ubuntu", "debian") end
  ignore_failure true
  returns 1
  action :nothing
end

package java_pkg do
  response_file "java.seed"
  action :install
  notifies :run, resources(:execute => "update-java-alternatives"), :immediately
end

package "ant"
package "groovy"
package "groovy-doc"

package "scala"
package "scala-library"

# package "maven2"
# Packaged maven2 is old, lets grab a nightly of 3.x

execute "unzip-maven" do
  command "unzip -o /tmp/apache-maven-3.0-SNAPSHOT-bin.zip -d /opt"
  returns 0
  action :nothing
end

remote_file "/tmp/apache-maven-3.0-SNAPSHOT-bin.zip" do
  source "https://grid.sonatype.org/ci/view/Maven%203.0.x/job/maven-3.0.x-bootstrap/jdk=1.5,label=ubuntu/lastSuccessfulBuild/artifact/trunk/apache-maven/target/apache-maven-3.0-SNAPSHOT-bin.zip"
  mode 0755
  owner "root"
  group "root"
  notifies :run, resources(:execute => "unzip-maven"), :immediately
end

template "/opt/apache-maven-3.0-SNAPSHOT/conf/settings.xml" do
  mode 0644
  source "settings.xml.erb"
end



