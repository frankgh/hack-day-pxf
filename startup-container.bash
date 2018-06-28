#! /usr/bin/env bash
# start pxf here
source /opt/gcc_env.sh
export JAVA_HOME=/etc/alternatives/java_sdk
export GPHOME=/usr/local/gpdb
export HADOOP_ROOT=/usr/hdp/current
export PXF_HOME=/usr/local/gpdb/pxf
export PG_MODE=GPDB
cat <<EOF >/tmp/core-site.xml
<?xml version="1.0" encoding="UTF-8"?>
<?xml-stylesheet type="text/xsl" href="configuration.xsl"?>
<configuration>
    <property>
        <name>fs.defaultFS</name>
        <value>hdfs://${NAMENODE_ADDRESS}:8020</value>
    </property>
</configuration>
EOF
sudo rm /etc/hadoop/conf/core-site.xml
sudo mv /tmp/core-site.xml /etc/hadoop/conf/
sed -i -e 's|^[[:blank:]]*export PXF_USER_IMPERSONATION=.*$|export PXF_USER_IMPERSONATION=false|g' ${PXF_HOME}/conf/pxf-env.sh
sed -i -e 's|<Executor maxThreads="300"|<Executor maxThreads="1"|g' ${PXF_HOME}/tomcat-templates/conf/server.xml
sed -i -e 's|minSpareThreads="50"|minSpareThreads="1"|g' ${PXF_HOME}/tomcat-templates/conf/server.xml
$PXF_HOME/bin/pxf init
$PXF_HOME/bin/pxf start
tail -f ${PXF_HOME}/logs/catalina.out
