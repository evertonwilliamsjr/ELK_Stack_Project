# GT_Cybersecurity_Project
A collection of my Cybersecurity tasks completed.

## Automated ELK Stack Deployment

The files in this repository were used to configure the network depicted below.

![atl text](https://github.com/bodmoncyba/GT_Cybersecurity_Project/blob/main/Diagrams/Azure_ELK-Server.png?raw=true "ELK-Server vNet Diagram")

These files have been tested and used to generate a live ELK deployment on Azure. They can be used to either recreate the entire deployment pictured above. Alternatively, select portions of the yml and config file may be used to install only certain pieces of it, such as Filebeat.

+ [Ansible Playbook](https://github.com/bodmoncyba/GT_Cybersecurity_Project/blob/main/Ansible/ansible-playbook.yml)
+ [Ansible Hosts](https://github.com/bodmoncyba/GT_Cybersecurity_Project/blob/main/Ansible/hosts)
+ [Ansible Config file](https://github.com/bodmoncyba/GT_Cybersecurity_Project/blob/main/Ansible/ansible.cfg)
+ [Ansible ELK Install and VM Config](https://github.com/bodmoncyba/GT_Cybersecurity_Project/blob/main/Ansible/install-elk.yml)
+ [Filebeat Playbook](https://github.com/bodmoncyba/GT_Cybersecurity_Project/blob/main/Ansible/roles/filebeat-playbook.yml)
+ [Filebeat Config file](https://github.com/bodmoncyba/GT_Cybersecurity_Project/blob/main/Ansible/files/filebeat-config.yml)
+ [Metricbeat Playbook](https://github.com/bodmoncyba/GT_Cybersecurity_Project/blob/main/Ansible/roles/metricbeat-playbook.yml)
+ [Metricbeat Config file](https://github.com/bodmoncyba/GT_Cybersecurity_Project/blob/main/Ansible/files/metricbeat-config.yml)

Configure your jump box to run Docker containers by installing docker.io and installing an Ansible container.
+ Run `sudo apt update` then `sudo apt install docker.io` in your GitBash CLI

Verify Docker service is running
+ Run `sudo systemctl status docker`
  + *Note: If the Docker service is not running, start it by running:*
  + `sudo systemctl start docker`

Once Docker is installed, pull the container by running:
+ `sudo docker pull cyberxsecurity/ansible`

Launch the Ansible container and connect to it by running:
+ `sudo docker run -ti cyberxsecurity/ansible:latest bash` to start the container.
[View Image]

To reconnect after exiting run:
+ `sudo docker container list -a`
+ `sudo docker start [container name or containerID]`
+ `sudo docker attach [container name or containerID]`

Once downloaded, find the [ansible.cfg] file located in your /etc/ansible directory to update remote_user = sysadmin.
+ Follow these steps:
```python
cd /etc/ansible/
ls 
nano ansible.cfg
CTRL + W > enter remote_user 
change remote_user to sysadmin
```
Assign sysadmin and SSH token to Web-1, Web-2, Web-3 and ELK-Server VM in the Azure portal.
+ Run `ssh-keygen` to create a SSH key when connected to the Ansible container
+ Run `ls .ssh/` to view your keys
+ Run `cat .ssh/id_rsa_pub` to display your public key
+ Copy your entire public key string and navigate to Web-1, Web-2, Web-3, and ELK-Server detail's page in the Azure portal. Scroll down on the left panel and paste the public key into *Reset Password* found in the 'Support + troubleshooting' section.
[Image]

This document contains the following details:
- Description of the Topology
- Access Policies
- ELK Configuration
  - Beats in Use
  - Machines Being Monitored
- How to Use the Ansible Build
---
### Description of the Topology

The main purpose of this network is to expose a load-balanced and monitored instance of DVWA, the D*mn Vulnerable Web Application.

Load balancing ensures that the application will be highly *available,* in addition to restricting *traffic* to the network.
- **What aspect of security do load balancers protect?** Load balancers protect against denial-of-service (DoS) attacks. Since the load balancer sits between the clients and the servers it can analyze the incoming traffic and better determine which servers to forward the traffic to. The logical distribution of traffic by the load balancer prevents one particular server from getting overloaded with traffic resulting in uninterrupted access of your website. Load balancers offer a health probe function that regularly checks the endpoint status of all machines behind the load balancer before forwarding traffic. If a machine is non-functional the load balancer will divert traffic from the malfunctioning machine until the issue is resolved. Load balancers enhance user experience by providing additional security, performance, and resilience to your application.

- **What is the advantage of a jump box?** A jump box limits access from the public to a virtual network. In order to access other virtual machines within the virtual network you would need the private IP addresses of those machines. Having a jump box or jump server within a virtual network allows network segmentation, and additional security that enhances access controls to a virtual network and its contents.

Integrating an ELK server allows users to easily monitor the vulnerable VMs for changes to the _data_ and system _logs_.
- **What does Filebeat watch for?** Filebeat monitors the log files or locations that you specify, collects log events, and forwards them either to Elasticsearch, Logstash or Kibana for indexing.
- **What does Metricbeat record?** Metricbeat periodically collects metrics from the operating system and from services running on the server. Metricbeat takes the metrics and statistics that it collects and ships them to the output that you specify, such as Elasticsearch, Logstash or Kibana.


The configuration details of each machine may be found below. 
_Note: Use the [Markdown Table Generator](http://www.tablesgenerator.com/markdown_tables) to add/remove values from the table._

| Name                 | Function                  | IP Address          | Operating System |
|:----------------------|:---------------------------|:---------------------|:------------------|
| Jump-Box-Provisioner | Gateway w/ Docker-Ansible | 10.0.0.4 /Public IP | Ubuntu Linux     |
| Web-1                | Web Server w/ DVWA        | 10.0.0.5            | Ubuntu Linux     |
| Web-2                | Web Server w/ DVWA        | 10.0.0.6            | Ubuntu Linux     |
| Web-3                | Redundant Server w/ DVWA  | 10.0.0.7            | Ubuntu Linux     |
| ELK-Server           | ELK Container w/ Kibana   | 10.1.0.4 /Public IP | Ubuntu Linux     |
| Load Balancer        | Reverse Proxy             | Public IP           | Ubuntu Linux     |


- Follow these steps below to create a Load Balancer for Web-1, Web-2 and Web-3 in Azure:
 - i. Create a load balancer
 - ii. Create a Virtual Machine Web-1 with Availability Set
 - iii. Create a Virtual Machine Web-2 with Availability Set
 - iv. Create a Virtual Machine Web-3 with Availability Set
 - v. Create a Load Balancing Rule
 - vi. Allow the AzureLoadBalancer Service in Security Group within the Virtual Network

- Follow these steps to evaluate the instances of the redundancy for Web-1, Web-2 and Web-3 VMs:
 - i. Verify that the DVWA website is accessible from your web browser.
  -	Open your Chrome browser > in your address bar type: _http://[Load-Balancer-External-IP]/setup.php_
-	Confirm successful by viewing image: [DVWA Redundancy Test]()
 - ii. Stop running Web-1 and Web-2 VMs from the Azure portal. Refresh the DVWA webpage and confirm if you still have access. [View image]()
 - iii. Lastly, stop running Web-3 VM to ensure no access to the DVWA website and refresh the DVWA webpage. 
[View image]()

---
### Access Policies

The machines on the internal network are not exposed to the public Internet. 

The _ELK-Server and Jump-Box-Provisioner_ VMs  are the only machines that can accept connections from the Internet. Access to these machines is only allowed from the following IP addresses:
- Workstation’s Public IP via TCP port 5601 - ELK-Server
- Workstation’s Public IP via SSH/TCP port 22 - Jump-Box-Provisioner


Machines within the network can only be accessed by local _Workstation_ and _Jump-Box-Provisioner_.
- **Which machine did you allow to access your ELK VM? What was its IP address?**
-- Jump-Box-Provisioner IP: 10.0.0.4 via SSH port 22
-- Workstation IP: Public IP via TCP port 5601

A summary of the access policies in place can be found in the table below.

| Name     | Publicly Accessible | Allowed IP Addresses |
|:----------|:---------------------|:----------------------|
| Jump-Box-Provisioner | Yes | Workstation Public IP on SSH 22 |
| Web-1    | No | 10.0.0.4 on SSH 22 |
| Web-2    | No | 10.0.0.4 on SSH 22 |
| Web-3    | No | 10.0.0.4 on SSH 22 |
| ELK-Server | Yes | Workstation Public IP on TCP 5601 |
| Load Balancer | Yes | Workstation Public IP on HTTP 80 |
---
### Elk Configuration

Ansible was used to automate configuration of the ELK machine. No configuration was performed manually, which is advantageous because Ansible allows you to seamlessly deploy complex multi-tier applications within your network. **Not an expert in writing custom code to automate your systems?** No worries. Ansible lets you list specified tasks to be performed by writing a playbook that reads YAML code. Per your input into your playbook .yml file, Ansible works in the background and figures out how to get your systems to the state you determined.   

The playbook implements the following tasks:
- Specifies a different host and username: 
- The first task of the install-elk playbook installs docker.io on the ELK-Server VM from Ubuntu repositories
- Python3-pip is then installed on the ELK-Server VM from Ubuntu repositories 
- Install Docker module directly from PyPI
- Since ELK requires more virtual memory, the next three tasks include increase the virtual memory, increase virtual memory on restart, and use more memory 
- The next task downloads and launches a Docker ELK container with a parameter of _restart_policy: always_, which allows the ELK container to spin up after a restart and disregards the need to manually start the ELK container. Included in this task are a list of ports to publish from the container to the host
- Lastly, this task enables Docker on boot which negates manually starting Docker
  + View [install-elk.yml](https://github.com/bodmoncyba/GT_Cybersecurity_Project/blob/main/Images/install-elk) playbook

The following [docker ps output](https://github.com/bodmoncyba/GT_Cybersecurity_Project/blob/main/Images/docker_ps_output.png) screenshot displays the result of running `docker ps` after successfully configuring the ELK instance.
---
### Target Machines & Beats
This ELK server is configured to monitor the following machines:
- Web-1: 10.0.0.5
- Web-2: 10.0.0.6
- Web-3: 10.0.0.7

We have installed the following Beats on these machines:
- **Filebeat and Metricbeat**

These Beats allow us to collect the following information from each machine:
- _`Filebeat`_ helps generate and organize log files to send to Logstash and Elasticsearch. It logs information about the file system, including which files have been changed and when. Filebeat is often used to collect log files from very specific files, such as those generated by Apache, Microsoft Azure tools, the Nginx web server, and MySQL databases. Connect to Kibana and check the logs for changes made to the file system which can be filtered by a specific time or commonly used time intervals. _`Metricbeat`_ shows metrics on the Docker containers running, such as the Number of Containers, CPU usage(%), Memory usage(%), NetworkIO and DiskIO statistics.
---
### Using the Playbook
In order to use the playbook, you will need to have an Ansible control node already configured. Assuming you have such a control node provisioned: 

SSH into the control node and follow the steps below:

For ELK-Server VM Configuration:

- Copy the [Ansible ELK Install and VM Config](https://github.com/bodmoncyba/GT_Cybersecurity_Project/blob/main/Ansible/install-elk.yml) file to `/etc/ansible`.

- Execute this command to run playbook: `ansible-playbook install-elk.yml`

For Filebeat:
- Download Filebeat configuration file by running this command:
```python
curl -L -O https://gist.githubusercontent.com/slape/5cc350109583af6cbe577bbcc0710c93/raw/eca603b72586fbe148c11f9c87bf96a63cb25760/Filebeat > /etc/ansible/filebeat-config.yml
```
- Copy the [filebeat-config.yml](https://github.com/bodmoncyba/GT_Cybersecurity_Project/blob/main/Ansible/files/filebeat-config.yml) file to /etc/ansible/files/filebeat-config.yml.

- Update the _filebeat-config.yml_ file to include the following:
```python 
output.elasticsearch:
# Array of hosts to connect to.
   hosts: ["10.1.0.4:9200"]
   username: "elastic"
   password: "changeme"

# This requires a Kibana endpoint configuration.
 setup.kibana:
   host: "10.1.0.4:5601"
```

- Run the [filebeat-playbook.yml] using this command `ansible-playbook filebeat-playbook.yml` and navigate to _http://[your.ELK-Sever-Public.IP]:5601/app/kibana > Logs: Add log data > System logs > Module status > Check data_ to check that the installation worked as expected.
[filebeat-playbook.yml](https://github.com/bodmoncyba/GT_Cybersecurity_Project/blob/main/Ansible/roles/filebeat-playbook.yml)
View [Filebeat Successful](https://github.com/bodmoncyba/GT_Cybersecurity_Project/blob/main/Images/filebeat_installation_complete.png)


For Metricbeat:
- Download Metricbeat configuration file by running this command:
```python
curl -L -O https://gist.githubusercontent.com/slape/58541585cc1886d2e26cd8be557ce04c/raw/0ce2c7e744c54513616966affb5e9d96f5e12f73/metricbeat > /etc/ansible/metricbeat-config.yml
```
- Copy the [metricbeat-config.yml](https://github.com/bodmoncyba/GT_Cybersecurity_Project/blob/main/Ansible/files/metricbeat-config.yml) file to /etc/ansible/files/metricbeat-config.yml.
- Update the _metricbeat-config.yml_ file to include the following:
```python 
output.elasticsearch:
# Array of hosts to connect to.
   hosts: ["10.1.0.4:9200"]
   username: "elastic"
   password: "changeme"

# This requires a Kibana endpoint configuration.
 setup.kibana:
   host: "10.1.0.4:5601"
```
- Run the [metricbeat-playbook.yml](https://github.com/bodmoncyba/GT_Cybersecurity_Project/blob/main/Ansible/metricbeat-playbook.yml) using this command `ansible-playbook metricbeat-playbook.yml` and navigate to http://[your.ELK-Sever-Public.IP]:5601/app/kibana > Metrics: Add metric data > Docker metrics > Module status > Check data to check that the installation worked as expected. 

View [Metricbeat Successful](https://github.com/bodmoncyba/GT_Cybersecurity_Project/blob/main/Images/metricbeat_installation_complete.png)


- **Which file is the playbook? Where do you copy it?**
- For Ansible we created the _ansible-playbook.yml_ as our playbook which was created in `/etc/ansible/` directory. See [Ansible Playbook](https://github.com/bodmoncyba/GT_Cybersecurity_Project/blob/main/Ansible/ansible-playbook.yml) for final solution.

-For Filebeat we created _filbeat-playbook.yml_ as our playbook and copied it to `/etc/ansible/roles/filebeat-playbook.yml`. See [Filebeat Playbook](https://github.com/bodmoncyba/GT_Cybersecurity_Project/blob/main/Ansible/roles/filebeat-playbook.yml) for final solution.

- - For Metricbeat we created _metricbeat-playbook.yml_ as our playbook and copied it to `/etc/ansible/roles/metricbeat-playbook.yml`. See [Metricbeat Playbook](https://github.com/bodmoncyba/GT_Cybersecurity_Project/blob/main/Ansible/filebeat-playbook.yml) for final solution.

**Which file do you update to make Ansible run the playbook on a specific machine?**
- You have to edit the ansible _hosts_ file and list the private IP addresses of the webservers that need to be accessed. 
- Run `pwd` to verify you are in the correct directory, which should be `/etc/ansible`. This is the directory where the ansible hosts file lives. Use `nano hosts` command to view hosts file for edit.
```python
#List the IP addresses of your webservers
[webservers]
10.0.0.5 ansible_python_interpreter=/usr/bin/python3
10.0.0.6 ansible_python_interpreter=/usr/bin/python3
10.0.0.7 ansible_python_interpreter=/usr/bin/python3

#List the IP address of your ELK server
#There should ONLY be one IP address listed for [elk]
[elk]
10.1.0.4 ansible_python_interpreter=/usr/bin/python3
```

**How do I specify which machine to install the ELK server on versus which to install Filebeat on?**
- After adding the private IP addresses of your webservers go to your _*playbook.yml_ file and specify whether you want the playbook installed on your webservers or your ELK server.  
```python
---
  - name: Configure Elk VM with Docker
    hosts: elk
    remote_user: sysadmin
    become: true
    tasks:
```
`In the above snippet from the _[install-elk.yml]_ file I specified "elk" as the hosts or the group of machines targeted for this installation that can only be performed by a "sysadmin" remote_user`

##How to Edit the Ansible Configuration file

- While connected to your Ansible container your `pwd` should be similar to  `root@8f57213ec250:/etc/ansible#’ then `nano ansible.cfg` to view configuration file for edit.

- While inside the nano text editor, Press CTRL + W > enter remote_user > then update line to reflect `remote_user = sysadmin`
--`sysadmin` is the remote user that has authority over ansible.

- _Which URL do you navigate to in order to check that the ELK server is running?
  + In web browser: http://[your.ELK-VM-Public.IP]:5601/app/kibana
  - On localhost: sysadmin@10.1.0.4:curl localhost:5601/app/kibana

_As a **Bonus**, provide the specific commands the user will need to run to download the playbook, update the files, etc._
---
### ADDITONAL NOTES:
#### How to get Filebeat installer :
1.	Login to Kibana > Logs : Add log data > System logs > DEB > Getting started
2.	Copy: `curl -L -O https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-7.6.1-amd64.deb`
# How to get the Metricbeat installer:
1.	Login to Kibana > Add Metric Data > Docker Metrics > DEB > Getting Started
2.	Copy: `curl -L -O https://artifacts.elastic.co/downloads/beats/metricbeat/metricbeat-7.6.1-amd64.deb`

#### How to Create the ELK Installation and VM Configuration
See the [install-elk.yml](https://https://github.com/bodmoncyba/GT_Cybersecurity_Project/blob/main/Ansible/install-elk.yml) file

### [Cheatsheat]

****
_____
