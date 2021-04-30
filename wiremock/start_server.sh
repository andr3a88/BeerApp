#!/bin/bash
 
VERSION=2.27.2
PORT=3900
 
if ! [ -f "wiremock-standalone-$VERSION.jar" ];
then
   curl -O https://repo1.maven.org/maven2/com/github/tomakehurst/wiremock-standalone/$VERSION/wiremock-standalone-$VERSION.jar
fi
 
java -jar wiremock-standalone-$VERSION.jar --port $PORT --verbose
