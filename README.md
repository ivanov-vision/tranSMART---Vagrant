# tranSMART
# A vagrant based tranSMART instance.

# Installation

git clone https://github.com/ivanov-vision/tranSMART.git

cd ./tranSMART-master

vagrant box update

vagrant up

Installation will take around 10 minutes depending on machine. 

After installation is complete, allow couple of minutes for application build up.

Then

open a browser

http://127.0.0.1:8080/transmart

username = admin

password = admin



# Prerequisites Versions:

Used - Vagrant 2.0.1 - from Vagrant - https://www.vagrantup.com/

Used - Oracle VM Virtualbox 5.2.8 - from Oracle - https://www.virtualbox.org/

Used- Ubuntu 14.04 LTS - from Vagrantcloud - https://app.vagrantup.com/boxes/search




# Log files:

/var/lib/tomcat7\logs\catalina.out



# Application folders:

/var/lib/tomcat7/webapps/transmart.war

# Future Work

- data loaders such as: tMDataLoader and Kettle (https://wiki.transmartfoundation.org/display/transmartwiki/Data+Curators+and+Loaders)

- https support

- Azure and Openstack Support. 
