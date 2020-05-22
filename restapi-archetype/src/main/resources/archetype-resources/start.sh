#!/usr/bin/env sh

PATH_ARG="$0"
PATH_DIR=`dirname "$PATH_ARG"`
[ -z "$SERVICE_HOME" ] && SERVICE_HOME=`pwd`

JAVA_OPTS=" -Xmx${JVM_XMX:-512m} \
-Xms${JVM_XMS:-512m} \
-XX:+UseG1GC \
-XX:G1HeapRegionSize=${JVM_G1_G1HEAPREGIONSIZE:-16m} \
-XX:MaxGCPauseMillis=${JVM_G1_MAXGCPAUSEMILLIS:-200} \
-XX:InitiatingHeapOccupancyPercent=${JVM_G1_InitiatingHeapOccupancyPercent:-30} \
-XX:ParallelGCThreads=${JVM_ParallelGCThreads:-1} \
-XX:ConcGCThreads=${JVM_ConcGCThreads:-1} \
-XX:+PrintGCDetails \
-XX:+PrintGCDetails \
-XX:+PrintGCDateStamps \
-XX:+PrintGCApplicationConcurrentTime \
-XX:+PrintHeapAtGC \
-Xloggc:gc.log"

_RUNJAVA=${JAVA_HOME}/bin/java
[ -z "$JAVA_HOME" ] && _RUNJAVA=java

for i in "$SERVICE_HOME"/libs/*.jar
do
    CLASSPATH="$i:$CLASSPATH"
done

SERVICE_CONFIG_FILE="${SERVICE_HOME}/application.yml"
SERVICE_OPTIONS=" -Dspring.config.location=${SERVICE_CONFIG_FILE}"

eval exec "\"$_RUNJAVA\" ${JAVA_OPTS} ${SERVICE_OPTIONS} -classpath $CLASSPATH $JAVA_HOME/target/${artifactId}.jar &"

if [ $? -eq 0 ]; then
    sleep 1
	echo "${artifactId} started successfully!"
else
	echo "${artifactId} started failure!"
	exit 1
fi