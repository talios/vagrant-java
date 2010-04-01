# package "maven2"
# Packaged maven2 is old, lets grab a nightly of 3.x

remote_file "/opt/apache/apache-maven-3.0-SNAPSHOT-bin.zip" do
  source "https://grid.sonatype.org/ci/view/Maven%203.0.x/job/maven-3.0.x-bootstrap/jdk=1.5,label=ubuntu/lastSuccessfulBuild/artifact/trunk/apache-maven/target/apache-maven-3.0-SNAPSHOT-bin.zip"
  mode 0755
  owner "root"
  group "root"
  notifies :run, resources(:execute => "unzip /opt/apache/apache-maven-3.0-SNAPSHOT-bin.zip -d /opt/apache"), :immediately
end



