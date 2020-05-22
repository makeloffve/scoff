#!/usr/bin/env sh

set MAVEN_OPTS=-XX:MaxPermSize=128M -Xmx512m -Xms512m

_RUNMAVEN=${MAVEN_HOME}/bin/mvn
[ -z "$MAVEN_HOME" ] && _RUNMAVEN=mvn

$_RUNMAVEN package