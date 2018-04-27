#!/bin/bash

. ./params.conf

cd /usr/src/;

if [ ! -d "TST-WEB" ]; then
# Control will enter here if $DIRECTORY doesn't exist.
  sudo git clone $repository ;
fi

cd /usr/src/TST-WEB/webtest/dist/;

if [ -f "webtest.war" ]; then

cd /opt/wildfly/bin/;

#deploy the war file in the wildfly-jboss server
sudo ./jboss-cli.sh --connect command="deploy $warfile  --force";

fi

#check deployed application and get the http response code
responsecode=$(sudo curl -s -i -o /dev/null -w "%{http_code}\n" $weburl);

if [ $responsecode -eq "200" ]; then
sudo touch /sucess-$responsecode.log;
else
sudo touch /err-$responsecode.log;
fi
~
