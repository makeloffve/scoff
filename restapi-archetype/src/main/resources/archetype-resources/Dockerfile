FROM openjdk:11.0.5-jre-slim
MAINTAINER cjgu
ENV JVM_XMS "512m"
ENV JVM_XMX "512m"
ENV JVM_G1_G1HEAPREGIONSIZE "16m"
ENV JVM_G1_MAXGCPAUSEMILLIS 200
ENV JVM_G1_InitiatingHeapOccupancyPercent 30
ENV JVM_ParallelGCThreads 1
ENV JVM_ConcGCThreads 1
ENV SERVICE_CONFIG_FILE "/home/app/config/application.yaml"
ADD ./start.sh /home/app/start.sh
ADD ./target/xxx-xxx.jar /home/app/xxx-xxx.jar
ENTRYPOINT ["sh", "/home/app/start.sh"]