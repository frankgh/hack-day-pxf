# hack-day-pxf

PXF is an extension framework that allows GPDB or any other database to query external distributed datasets. The framework is built in Java and provides built-in connectors for accessing data of various formats(text,sequence files, avro, orc,etc) that may exist inside HDFS files, Hive tables, HBase tables and many more stores. PXF consists of a server side JVM based component and a C client component which serves as the means for GPDB to interact with the PXF service. This module only includes the PXF C client and the build instructions only builds the client. Using the 'pxf' protocol with external table, GPDB can query external datasets via PXF service that runs alongside GPDB segments.

Currently, PXF is tighly coupled to GPDB. Our goal is to decouple PXF from GPDB 
by deploying an elastic PXF pod to Kubernetes. A tipical PXF workload will be
sporadic, therefore assigning elastic resources to PXF is desirable in large
deployments where resources can be allocated dynamically, leaving enough resources
to the cluster.
