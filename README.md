# infrastructure-hw

## Overview
This repo deploys the necessary infrastructure to locally test a producer and consumer system mediated by a messaging queue (Kafka). The producer/consumer services are built with Flask and Socket.IO to emit messages received from a Kafka topic to connected web clients in real-time.

## Structure
- `/hello-world` contains the producer and consumer code used in docker images
- `/helm` contains the k8s manifest necessary to deploy images to cluster

## Requriements
Ensure that you have the following technologies prior to running the system locally
- Docker
- Minikube
- kubectl
- helm

If not try running the `install_requirements.sh`
```bash
./install_requirements.sh
```

## Running Local Custer
Locally we will use helm to apply k8s manifests to our minikube configuration. This script will deploy a kafka cluster and environmental based configurations for producer, consumer, and kafka topics. The three environments are created by this configuration are default, dev, and prod.

```bash
./setup.sh
```

## Viewing real-time messaging system
- default: [localhost:8001](http://localhost:8002/)
- dev: [localhost:8002](http://localhost:8002/)
- prod: [localhost:8003](http://localhost:8003/)

To kill port-forward processes created by the `setup.sh` script run the 
```bash
./kill_port_forward.sh
```

## Future Directions

- Data

The messages broadcast from the producer are not being persisted. Meaning that a message will be generated and the consumer will add it to the html but if the consumer UI is refreshed then we lose all the messages that we have seen. Depending on user needs we may want to persist the data and paginate.

- Security

Best practices preach adding encryption to our data so malicious users can't read data being communicated. Next, it would be a good idea to add some authentication so that only enabled users can see the messages or subscribe to a specific topic.

- Ingress & Egress
Adding a way to send and recieve traffic to the servers behind the cluster without port-forwarding will be necessary to expose our services to the world.

## Your mission

For this assignment, you're going to create the infrastructure for an application with a small set of services.

- One service needs to broadcast `Hello world` at random intervals. Make the interval anywhere from 1 to 10 seconds, with each the time until the next broadcast each chosen randomly.

- Another service needs to receive the `Hello world` broadcasts.

- Then a user should be able to view the `Hello world` broadcasts, as they arrive, from a web browser.

### Other requirements

- Use whatever languages and frameworks you want to create the services.
- We're aiming to just run this application on an engineer's local machine, not the cloud; design your solution for `minikube`
- Your solution should have the minimum number of manual setup steps necessary.
- Use any adjacent infrastructure tools you think make for a more elegant solution.

## Submission

- Fork this repository on GitHub. Develop a solution on your fork. Extra points for good git hygiene.
- Include specific instructions in your README about pre-requisites and setup steps. Another engineer should be able to go from zero to running your solution on their local machine.
- Either send us the link to your repository (if you make it public) or email us a zipped-up folder.
