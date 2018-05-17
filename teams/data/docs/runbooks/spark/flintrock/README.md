# [Flintrock](https://github.com/nchammas/flintrock)

Flintrock is a command-line tool for launching Apache Spark clusters with a
polished CLI and configurable defaults, making easy to destroy and start
clusters without remembering the specific options. You'll need a working
version of Python 3 to use it. The next steps assume you're under the
`flintrock` directory.

1. Tweak [`config.yaml`](config.yml) according to your needs.
    - You can set a `spot-price` to use cheap spot instances.
    - Change `num-slaves` to the desired number of nodes. This can be changed
      later in case you want to experiment first with 1 or 2 nodes.
1. Run `make launch` to fire up the cluster.
1. Once everything finished the cluster should be up. Login with `make login`.
1. Install Anaconda following the commands in the   [`install_anaconda.sh`](install_anaconda.sh) file.
1. Copy the content of [`spark-defaults.conf`](spark-defaults.conf) to `$SPARK_HOME/conf/spark-defaults.conf`. Make sure you've replaced the `spark.master` URI and the node memory value according to the instances you're using
1. Update the master node `~/.bashrc` file with the content of [`exports.sh`](exports.sh)

You can now run `pyspark` to fire up a Jupyter Notebook in the port 7777. To interact with it you need to create a tunneled connection over SSH using `ssh -i /path/to/your.pem -L localhost:7776:localhost:7777 ec2-user@spark-master-public-ip`

Once you're connected, head over [localhost:7776](http://localhost:7776) and start doing big data!
