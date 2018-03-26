#echo "ECHO ===============================================================================================================================>sudo su"
#sudo su

echo "ECHO ===============================================================================================================================> apt-get update"
apt-get update

echo "ECHO ===============================================================================================================================> apt-get install -y make"
apt-get install -y make

echo "ECHO ===============================================================================================================================> apt-get install -y zip"
apt-get install -y zip

echo "ECHO ===============================================================================================================================> apt-get install -y curl"
apt-get install -y curl

echo "ECHO ===============================================================================================================================> apt-get install -y git"
apt-get install -y git

echo "ECHO ===============================================================================================================================> apt-get install -y openjdk-7-jdk"
apt-get install -y openjdk-7-jdk

echo "ECHO ===============================================================================================================================> apt-get install -y ant"
apt-get install -y ant

echo "ECHO ===============================================================================================================================> apt-get install -y php5"
apt-get install -y php5

echo "ECHO ===============================================================================================================================> apt-get install -y tomcat7"
apt-get install -y tomcat7

echo "ECHO ===============================================================================================================================> apt-get install -y postgresql-9.3"
apt-get install -y postgresql-9.3

echo "ECHO ===============================================================================================================================> apt-get install -y apache2 "
apt-get install -y apache2 

echo "ECHO ===============================================================================================================================> sudo -i -u postgres"
sudo su postgres -c "psql -c \"alter user postgres password  'postgres'\" "
#sudo su postgres -c "psql -c \"CREATE ROLE vagrant SUPERUSER LOGIN PASSWORD 'vagrant'\" "

echo "ECHO NEXT"

echo "ECHO ===================================================================================> curl -s http://get.sdkman.io | bash "
curl -s http://get.sdkman.io | bash

echo "ECHO ===================================================================================> source /root/.sdkman/bin/sdkman-init.sh"
source "/root/.sdkman/bin/sdkman-init.sh"

echo "ECHO ===================================================================================> sdk install grails 2.3.11"
sdk install grails 2.3.11

echo "ECHO ===================================================================================>curl transmart-data-release-16"
curl http://library.transmartfoundation.org/release/release16_2_0_artifacts/transmart-data-release-16.2.zip -o transmart-data-release-16.2.zip

echo "ECHO ===================================================================================>unzip transmart-data-release-16.2.zip"
unzip transmart-data-release-16.2.zip

echo "ECHO ======================================================================> mv transmart-data-release-16.2 transmart-data"
mv transmart-data-release-16.2 transmart-data

echo "ECHO ======================================================================> cd transmart-data"
cd transmart-data

echo "ECHO ======================================================================> sudo make -C env ubuntu_deps_root"
make -C env ubuntu_deps_root


#echo "ECHO ======================================================================> cd transmart-data"
#cd transmart-data

echo "ECHO ======================================================================> php env/vars-ubuntu.php > vars"
php env/vars-ubuntu.php > vars

echo "ECHO ======================================================================>source vars"
source vars

echo "ECHO ======================================================================>postgres bash -c source vars; PGSQL_BIN=/usr/bin/ PGDATABASE=template1 make -C ddl/postgres/GLOBAL tablespaces"
sudo su postgres bash -c "source vars; PGSQL_BIN=/usr/bin/ PGDATABASE=template1 make -C ddl/postgres/GLOBAL tablespaces"

echo "ECHO ======================================================================>make -C config install"
make -C config install

echo "ECHO ======================================================================>mkdir -p /usr/share/tomcat7/.grails/"
mkdir -p /usr/share/tomcat7/.grails/

echo "ECHO ======================================================================>mkdir -p /usr/share/tomcat7/.grails/transmartConfig/"
mkdir -p /usr/share/tomcat7/.grails/transmartConfig/

echo "ECHO ======================================================================>chown -R tomcat7:tomcat7 /usr/share/tomcat7/.grails"
chown -R tomcat7:tomcat7 /usr/share/tomcat7/.grails

echo "ECHO ======================================================================>cp /home/vagrant/transmart-data/config/Config.groovy /usr/share/tomcat7/.grails/transmartConfig/"
cp /home/vagrant/transmart-data/config/Config.groovy /usr/share/tomcat7/.grails/transmartConfig/

echo "ECHO ======================================================================>cp /home/vagrant/transmart-data/config/DataSource.groovy /usr/share/tomcat7/.grails/transmartConfig/"
cp /home/vagrant/transmart-data/config/DataSource.groovy /usr/share/tomcat7/.grails/transmartConfig/

echo "ECHO ======================================================================>cp  /root/.grails/transmartConfig/Config.groovy /usr/share/tomcat7/.grails/transmartConfig/"
cp  /root/.grails/transmartConfig/Config.groovy /usr/share/tomcat7/.grails/transmartConfig/

echo "ECHO =====================================================> make postgres"
make postgres

echo "ECHO =====================================================> export JAVA_HOME=/usr/lib/jvm/java-1.7.0-openjdk-amd64"
export JAVA_HOME=/usr/lib/jvm/java-1.7.0-openjdk-amd64

echo "ECHO =====================================================> curl http://library.transmartfoundation.org/release/release16_2_0_artifacts/transmart.war --output transmart.war"
curl http://library.transmartfoundation.org/release/release16_2_0_artifacts/transmart.war --output transmart.war

echo "ECHO =====================================================> cp -r transmart.war /var/lib/tomcat7/webapps/transmart.war"
cp -r transmart.war /var/lib/tomcat7/webapps/transmart.war

echo "ECHO =====================================================> sudo bash -c sudo bash -c 'source vars; TSUSER_HOME=~root/ make -C config/ install'"
sudo bash -c "source vars; TSUSER_HOME=~root/ make -C config/ install"

echo "ECHO =====================================================> sed -i 's/^JAVA_OPTS=.*/JAVA_OPTS"
sed -i 's/^JAVA_OPTS=.*/JAVA_OPTS="-Djava.awt.headless=true -Xmx'1024'm -XX:MaxPermSize=400m -XX:+UseConcMarkSweepGC"/' /etc/default/tomcat7

echo "ECHO =====================================================> service tomcat7 restart"
service tomcat7 restart


