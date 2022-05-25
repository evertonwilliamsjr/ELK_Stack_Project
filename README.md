# Automated ELK Stack Deployment

The files in this repository were used to configure the network depicted below.

![atl text](https://github.com/bodmoncyba/GT_Cybersecurity_Project/blob/main/Diagrams/Azure_ELK-Server.png?raw=true "ELK-Server vNet Diagram")

These files have been tested and used to generate a live ELK deployment on Azure. They can be used to either recreate the entire deployment pictured above. Alternatively, select portions of the yml and config file may be used to install only certain pieces of it, such as Filebeat.

+ [Ansible Playbook](https://github.com/bodmoncyba/GT_Cybersecurity_Project/blob/main/Ansible/ansible-playbook.yml)
+ [Ansible Hosts](https://github.com/bodmoncyba/GT_Cybersecurity_Project/blob/main/Ansible/hosts)
+ [Ansible Config file](https://github.com/bodmoncyba/GT_Cybersecurity_Project/blob/main/Ansible/ansible.cfg)
+ [ELK Installation](https://github.com/bodmoncyba/GT_Cybersecurity_Project/blob/main/Ansible/install-elk.yml)
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

| **Name                 | Function                  | IP Address          | Operating System** |
|:----------------------|:---------------------------|:---------------------|:------------------|
| Jump-Box-Provisioner | Gateway w/ Docker-Ansible | 10.0.0.4 /Public IP | Ubuntu Linux     |
| Web-1                | Web Server w/ DVWA        | 10.0.0.5            | Ubuntu Linux     |
| Web-2                | Web Server w/ DVWA        | 10.0.0.6            | Ubuntu Linux     |
| Web-3                | Redundant Server w/ DVWA  | 10.0.0.7            | Ubuntu Linux     |
| ELK-Server           | ELK Container w/ Kibana   | 10.1.0.4 /Public IP | Ubuntu Linux     |
| Load Balancer        | Reverse Proxy             | Public IP           | Ubuntu Linux     |


- Follow these steps below to create a Load Balancer for Web-1, Web-2 and Web-3 in Azure:
   1. Create a load balancer
   2. Create a Virtual Machine Web-1 with Availability Set
   3. Create a Virtual Machine Web-2 with Availability Set
   4. Create a Virtual Machine Web-3 with Availability Set
   5. Assign a Frontend IP configuration to your Load Balancer
   6. Add Web-1, Web-2, and Web-3 to the Backend pools
   7. Create a Health probe for traffic coming through HTTP port 80
   8. Create a Load balancing rule allow traffic through port 80
   9. _**By default, Azure allows access to the AzureLoadBalancer Service** based on Inbound Security Rule -65001_** 

- Follow these steps to evaluate the instances of the redundancy for Web-1, Web-2 and Web-3 VMs:
   1. Verify that the DVWA website is accessible from your web browser.
   2. Open your Chrome browser > in your address bar type: _http://[Load-Balancer-External-IP]/setup.php_
   3. [View image](https://github.com/bodmoncyba/GT_Cybersecurity_Project/blob/main/Images/DVWA_Successful.png) to confirm.
   4. Stop running Web-1 and Web-2 VMs from the Azure portal. Refresh the DVWA webpage and confirm if you still have access. 
     - [Redundancy Test Results](https://github.com/bodmoncyba/GT_Cybersecurity_Project/blob/main/Images/DVWA_Successful.png)
   6. Lastly, stop running Web-3 VM to ensure no access to the DVWA website and refresh the DVWA webpage. 
     - [Redundancy Test Results](https://github.com/bodmoncyba/GT_Cybersecurity_Project/blob/main/Images/DVWA_Failed.png)

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

| **Name     | Publicly Accessible | Allowed IP Addresses** |
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
  + View [install-elk.yml](https://github.com/bodmoncyba/GT_Cybersecurity_Project/blob/main/Images/install-elk.yml) playbook

The following [docker ps output](https://github.com/bodmoncyba/GT_Cybersecurity_Project/blob/main/Images/docker_ps_output.png) screenshots displays the result of running `sudo su` then `docker ps` on all webservers after successfully configuring the ELK instance.
![atl text](https://github.com/bodmoncyba/GT_Cybersecurity_Project/blob/main/Images/docker_ps_output.png?raw=true "ELK docker ps output")

![atl text](https://github.com/bodmoncyba/GT_Cybersecurity_Project/blob/main/Images/docker_ps_output_Web-1.png?raw=true "Web-1 docker ps output")

![atl text](https://github.com/bodmoncyba/GT_Cybersecurity_Project/blob/main/Images/docker_ps_output_Web-2.png?raw=true "Web-2 docker ps output")

![atl text](https://github.com/bodmoncyba/GT_Cybersecurity_Project/blob/main/Images/docker_ps_output_Web-3.png?raw=true "Web-3 docker ps output")
- Status on all webservers configured with the ELK instance should show as **Up**.
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

- Copy the [install-elk.yml](https://github.com/bodmoncyba/GT_Cybersecurity_Project/blob/main/Ansible/install-elk.yml) file to `/etc/ansible`.

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

- Run the [filebeat-playbook.yml](https://github.com/bodmoncyba/GT_Cybersecurity_Project/blob/main/Ansible/roles/filebeat-playbook.yml) using this command `ansible-playbook filebeat-playbook.yml` and navigate to _http://[your.ELK-Sever-Public.IP]:5601/app/kibana > Logs: Add log data > System logs > Module status > Check data_ to check that the installation worked as expected.

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

  - For Filebeat we created _filbeat-playbook.yml_ as our playbook and copied it to `/etc/ansible/roles/filebeat-playbook.yml`. See [Filebeat Playbook](https://github.com/bodmoncyba/GT_Cybersecurity_Project/blob/main/Ansible/roles/filebeat-playbook.yml) for final solution.

  - For Metricbeat we created _metricbeat-playbook.yml_ as our playbook and copied it to `/etc/ansible/roles/metricbeat-playbook.yml`. See [Metricbeat Playbook](https://github.com/bodmoncyba/GT_Cybersecurity_Project/blob/main/Ansible/metricbeat-playbook.yml) for final solution.

**Which file do you update to make Ansible run the playbook on a specific machine?**
- You have to edit the ansible _hosts_ file and list the private IP addresses of the webservers that need to be accessed. 
- Run `pwd` to verify you are in the correct directory, which should be `/etc/ansible`. This is the directory where the ansible hosts file lives. Use the `nano hosts` command to view hosts file for edit.
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
In the above snippet from the _install-elk.yml_ file I specified "elk" as the hosts or the group of machines targeted for this installation that can only be performed by a "sysadmin" remote_user.

## How to Edit the Ansible Configuration file

- While connected to your Ansible container your `pwd` should be similar to  `root@8f57213ec250:/etc/ansible#` then `nano ansible.cfg` to view configuration file for edit.

- While inside the nano text editor, Press [CTRL + W] > enter remote_user > then update line to reflect `remote_user = sysadmin`
  - `sysadmin` is the remote user that has authority over ansible.

- **Which URL do you navigate to in order to check that the ELK server is running?**
  + In web browser: _http://[your.ELK-VM-Public.IP]:5601/app/kibana_
  - On localhost: sysadmin@10.1.0.4:curl localhost:5601/app/kibana

### _As a **Bonus**, provided below are specific commands the user will need to run in order to download the playbooks, update the files, etc._

---
### ADDITONAL NOTES:
#### How to get Filebeat installer :
1.	Login to _Kibana > Logs : Add log data > System logs > DEB > Getting started_
2.	Copy: `curl -L -O https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-7.6.1-amd64.deb`
#### How to get the Metricbeat installer:
1.	Login to _Kibana > Add Metric Data > Docker Metrics > DEB > Getting Started_
2.	Copy: `curl -L -O https://artifacts.elastic.co/downloads/beats/metricbeat/metricbeat-7.6.1-amd64.deb`

#### How to Create the ELK Installation and VM Configuration
- View the [install-elk.yml](https://https://github.com/bodmoncyba/GT_Cybersecurity_Project/blob/main/Ansible/install-elk.yml) file.

---
---
## Key Commands

### SSH

Secure Shell sets up an encrypted connection between two machines. Commands given on the first machine are executed on the second machine and output from the second machine is sent back to the first machine. 

The result is the ability to control a remote machine using the command line while keeping all your actions private from any would be attacker or snooper.

#### ssh-keygen

The `ssh-keygen` command creates a private/public key pair that you can use to authenticate your SSH connections. Once created, the public key is copied to the server into the `~/.ssh/known_hosts` file.

```bash
# Create an ssh public/private key pair
ssh-keygen
```

You can create a password for your SSH key if you wish, but this isn't recommended if the SSH key is going to be used for automation purposes. 

#### ssh-copy-id

The `ssh-copy-id` command will copy the public ssh key into the correct location on the remote server.

```bash
# copy the public key for 'mykey' to the ~/.ssh/known_hosts file on a remote machine
ssh-copy-id -i ~/.ssh/mykey user@<host ip>
```

#### ssh

The `ssh` command creates an ssh connection to a remote machine. If you do not have an SSH key in place, you will be prompted for a password. 

```bash
# Connect to the machine with the IP address 10.10.0.4 using the 'admin' user.
ssh admin@10.10.0.4
```

You can create multiple keys for different purposes and different machines. To specify a particular key, use the `-i` flag.

```bash
# Connect to the machine at 10.10.0.4 using a specific 'mykey' identity
ssh -i mykey.pub admin@10.10.0.4
```
---
### Docker

Docker allows you to run Linux containers on any server or local machine. Containers are similar to a virtual machine, except they only run the resources necessary to complete their specific task.

A container typically only runs one task. This could be a web server, or a particular application or any program you choose. They are similar to an `app` on your phone. A container is completely self sufficient and has everything it needs to run. 

#### docker pull

`docker pull` will copy a container to the server so you can run it. 

```bash
# download the 'dvwa' container from the 'cyberxsecurity' docker repository
docker pull cyberxsecurity/dvwa
```

#### docker image ls

`docker image ls` lists all of the container images that are copied to the server. Each image can be used to create any number of containers. 

```bash
docker image ls
REPOSITORY               TAG                 IMAGE ID            CREATED             SIZE
cyberxsecurity/ansible   latest              6657e0b22542        11 days ago         303MB
ubuntu                   18.04               775349758637        7 weeks ago         64.2MB
```

#### docker container list -a

`docker container list -a` will list _all_ of the containers on the system, including containers that are not running.

#### docker run

`docker run` will create a container from the specified image.

```bash
# Run the cyberxsecurity/ansible container
docker run cyberxsecurity/ansible

# Run the container using the image ID 6657e0b22542 
docker run 6657e0b22542
```

#### docker start 

`docker start container_name` will start a stopped container. This does not _create_ a container from a container image. Instead, it will only start a container that you already have created.

#### docker stop

`docker stop` will stop a running container. This is similar to shutting down a VM.

```bash
# stop the ansible container
docker stop ansible
```

#### docker exec

`docker exec` will execute a command directly on a container and return the output of that command to you. This is commonly used to get a bash shell on the container by executing the bash command.

```bash
# run the `bash` command on a container named 'my-container'
docker exec -it my-container /bin/bash 
```

Here the `-it` flags stand for `interactive` and `terminal` or `interactive terminal` all together. The result is that this command returns a bash shell.

#### docker attach

`docker attach` will give you a shell on the specified container. This works similarly to an SSH connection and can be used instead of the `exec` command above to get a bash shell on a container.

```bash
# connect to the container named ansible
docker attach ansible
```

#### docker image rm

`docker image rm` removes an image from the server

```bash
# Remove the dvwa container image from the server
docker image rm dvwa
```
---
### Ansible

Ansible is a provisioner that can be used to configure any Linux machine. There is significant documentation for how to use Ansible on their website [HERE](https://docs.ansible.com/ansible/latest/user_guide/intro_getting_started.html).

#### ansible all -m ping 

Ansible usually needs a file full of commands called a 'playbook' in order to complete it's tasks. However, you can also execute single commands if you wish using the `-m` flag to specify the `module` you want to use.

With this command we are using the 'ping' module (`-m`) on 'all' of the machines listed in the `hosts` file.

```bash
# Ping all of the hosts in the hosts file using the ping module
ansible all -m ping
```

#### ansible-playbook

The `ansible-playbook` command will run the contents of a `playbook.yml` file. The playbook file can be named anything you wish as long as it ends in `.yml` and it has the correct formatting.

```bash
# Run the playbook 'my-playbook.yml' 
ansible-playbook my-playbook.yml
```


#### Ansible playbooks

Playbooks always carry the `.yml` extension and begin with `---` on the first line to signify that it is a YAML file.

The first few lines of the playbook will give global settings for the file and notate what machines the playbook is to use, if you would like to run the commands as `root`, and what `tasks` are to be completed.

```bash
---
- name: Config Web VM with Docker
  hosts: web
  become: true
  tasks:
```

In this Definition, we give the playbook a descriptive `name`, specify that is to run on the machines listed under the `web` headding in the `hosts` file, specify that all commands should be run as root, and then start listing the `tasks`.
  - `name:` can be anything you wish
  - `hosts:` specify what machines are to be used. Here we are using the `web` hosts.
  - `become: true` means: 'Become the root user for all the following commands'
  - `tasks:` starts the task section where all other commands/tasks will be listed.

#### Ansible apt module

Ansible modules can easily be found by googling 'Ansible module \<name-of-thing-you-want-to-do>'

The `apt` module lets you install applications using the apt-get commands. 

```bash
# Install nano. force `apt-get` to be used instead of just `apt`
  - name: Install nano
    apt:
      force_apt_get: yes
      name: nano
      state: present
```
See all of the `apt` module options [HERE](https://docs.ansible.com/ansible/latest/modules/apt_module.html)

#### Ansible pip module

The pip module allows you to install python packages as if you were using the command `pip install`

The syntax is just like the `apt` module.

```bash
  - name: Install Docker python module
    pip:
      name: docker
      state: present
```

See all of the pip module options [HERE](https://docs.ansible.com/ansible/latest/modules/pip_module.html)

#### Ansible docker-container

The `docker-container` module can be used to download and manage Docker containers. 

Here we are downloading the container `cyberxsecurity/dvwa`, staring the container, and forwarding the host port 80 to the container port 80

```bash
  - name: download and launch a docker web container
    docker_container:
      name: dvwa
      image: cyberxsecurity/dvwa
      state: started
      published_ports: 80:80
```

To see all of the `docker-container` module options, click [HERE](https://docs.ansible.com/ansible/latest/modules/docker_container_module.html)

****
****
****
