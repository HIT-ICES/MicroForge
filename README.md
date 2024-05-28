# MicroForge: An Integrated Platform for Accelerating Experiments in Microservice Research

The platform is constructed using the Kubernetes (K8s) API and incorporates key components like Istio and JMeter. It's intended to serve as a specialized experimental platform for microservice research. This platform encompasses various essential functions, such as managing microservices, instances, monitoring systems, measuring stress levels, managing route policies, and handling container images.
![[Architectural Design of MicroForge]](pic/Pasted%20image%2020240528141215.png)
## Main Function

- **Microservice Management：** This module is utilized for managing pertinent information regarding microservices within the system, encompassing fundamental details of microservices and their interdependencies. Users can freely add or remove microservices within the system using this module.
- **Instance Management：** This module is responsible for deploying corresponding microservices according to the given deployment plan and monitoring the execution status of the deployment plan. Through this module, researchers can achieve batch deployment of microservice instances automatically via API or web interface.
- **System Monitor：** Researchers need to analyse the runtime data of the microservices system to support their research content, so it is very important to monitor the whole microservices system in all aspects, including instances, request links and request status, as described below.
- **Stress Measure：** This module is responsible for simulating requests from different users to a specified service according to given configurations, monitoring the processing of all requests, as well as the operational status of service instances, and generating test reports. These reports are instrumental for measuring response times under current system configurations, quantifying service request capabilities, and assessing computational resource requirements for service operation.
- **Route Policy Management：** This module is tasked with configuring routing policies for inter-service requests within the system. This component is primarily built upon Istio. Depending on the configuration, it can implement routing policies at different levels of granularity, including service-level and instance-level routing strategies
- **Container Image Management：** This module is responsible for managing the container image cache on each machine within the cluster. It automatically downloads/deletes container images on each server node based on the provided configuration file to ensure consistency between the image cache status for each service and the specified configuration file.
## Requirements
- Kubernetes == 1.24.1
- Kubesphere == 3.3.2
- Istio == 1.18.1
- Jmeter ==
- Jaeger == 1.45.0
- Mysql >=8.0.19
- Elaticsearch >= 7.14.1
- Kibana >= 7.14.1
- Logstash >= 7.14.1
  Please make sure that you have installed and configured the above basic requirements, the above configuration for the author tested, according to the needs of their own choice of the above version, but pay attention to the version dependencies between the tools.
## Installation and Deployment
The platform consists of multiple microservices, each with its own deployment profile. The repositories for all the microservices are linked as submodules in this project. you can view the deployment profiles in each of the microservice repositories and deploy the appropriate microservices as needed.

Visit [localhost:8080] after deployment is complete
![[FrontEnd]](pic/Pasted%20image%2020240528144229.png)