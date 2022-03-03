# kafka-tools-docker
## What this is about

This is about to provide a docker-image to assist the developer working eg. with a kafka-cluster running in docker-compose by providing tools like:

* kafkacut
* kafka command line tools like
  * kafka-console-producer.sh ...
* python kafka-tools

With the help of them, the developer can inspect the kafka-setup, send and receive messages and more to debug problems...

## A hint how to integrate it into your compose setup
You could think you can just integrate it with something like this...
````
...
  tools:
    image: dancier/kafka-tools:latest
...
```
This will not work as the container will stop immediatly. This is expected behavior, as the image does not contain a long running task.
You can prevent this, be attaching a terminal to it, by configuring the image as follows:
...
  tools:
    image: dancier/kafka-tools:latest
    # To make the container not stop immediately
    stdin_open: true
    tty: true
...
