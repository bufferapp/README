#!/bin/sh

# Install required python packages
git clone https://github.com/mongodb/mongo-hadoop.git
cd mongo-hadoop/spark/src/main/python
python setup.py install

# Get JAR
cd /root
wget https://repo1.maven.org/maven2/org/mongodb/mongo-hadoop/mongo-hadoop-spark/2.0.0/mongo-hadoop-spark-2.0.0.jar
mv mongo-hadoop-spark-2.0.0.jar mongo-hadoop-spark.jar

# Install Anaconda
cd /root
wget https://repo.continuum.io/archive/Anaconda2-4.2.0-Linux-x86_64.sh
sh Anaconda2-4.2.0-Linux-x86_64.sh -b
source .bashrc

# Install pymongo
cd /root
git clone https://github.com/mongodb/mongo-python-driver
cd mongo-python-driver
python setup.py install

# Run pyspark
cd /root
pyspark --py-files mongo-hadoop/spark/src/main/python/pymongo_spark.py,/root/anaconda2/lib/python2.7/site-packages/pymongo-3.4.0-py2.7-linux-x86_64.egg \
--packages com.amazonaws:aws-java-sdk-pom:1.10.34,org.apache.hadoop:hadoop-aws:2.7.2
