#!/bin/sh 

LATEST=`wget -O- http://teamcity.labkey.org:8080/repository/download/bt36/.lastSuccessful/VERSION?guest=1`
wget -O '/tmp/pwiz-setup-'$LATEST'-x86.msi' 'http://teamcity.labkey.org:8080/repository/download/bt36/.lastSuccessful/pwiz-setup-'$LATEST'-x86.msi?guest=1'



