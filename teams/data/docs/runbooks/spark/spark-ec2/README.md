# [Spark EC2](https://github.com/amplab/spark-ec2)

`spark-ec2` allows you to launch, manage and shut down [Apache Spark](http://spark.apache.org/docs/latest/ec2-scripts.html) clusters on Amazon EC2. It automatically sets up Apache Spark and [HDFS](https://hadoop.apache.org/docs/stable/hadoop-project-dist/hadoop-hdfs/HdfsUserGuide.html) on the cluster for you. This method **is required if you want to get data from the production MongoDB collections** as done in [this project](https://github.com/bufferapp/buffer-spark-mongo).

1. Clone the `spark-ec2` repository locally running `git@github.com:amplab/spark-ec2.git`
1. Copy and run `launch.sh` (replace the AWS exports with your AWS Keys). When creating the cluster, the script will show a bunch of URLs. You'll need to grab the master node URL.
1. Once is running, you can log into the master node with `./spark-ec2/spark-ec2 login -i ~/path/key.pem spark`.
1. Append the content of the local `spark-defaults.conf` file into the `/root/spark/conf/spark-defaults.conf` file in the server
1. Update the master node `~/.bashrc` file with the content of [`exports.sh`](exports.sh)
1. Copy and execute the commands under [`setup.sh`](setup.sh) in the master node console.

The last command will run `pyspark` and fire up a Jupyter Notebook in a port. To interact with it you need to create a tunneled connection over SSH. To do this you can run `ssh -i /path/to/your.pem -L localhost:7776:localhost:7777 root@spark-master-public-ip`

Once you're connected, head over [localhost:7776](http://localhost:7776) and start doing big data!
