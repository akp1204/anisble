ansible-playbooks
=================

A repository of ansible-playbooks for deploying remote instances and common deployment strategies

Setting Up
====

#### Create a hosts file in the playbook

`roles/hosts`
```txt
[dev]
# An Amazon AMI host
192.168.1.12
```

#### Set your SSH Configure

Ansible can rely on your SSH configuration to connect to a specified host using the appropriate settings. This allows you to connect to hosts that require an identity file, or a non-standard port.

`~/.ssh/config`
```txt
Host dev
    HostName dev
    User ec2-user
    IdentityFile ~/.ssh/AWS.pem
```

Using a Playbook
===

```shell
cd playbook
ansible-playbook -i hosts <play>.yml --extra-vars "user=ec2-user"
```

Our Roles
===

- Python 2.7 (python27): Installs all the system packages required to run a modern science
  developer based instance of Python 2.7. The binaries are installed to
  /usr/local/ prefix, so python will be in /usr/local/bin/python

- Developer (dev): This role is used for basic development environments, it
  comes with ruby, and python and the standard development tools.
  1. Creates a developer account "dev" and installs YOUR ssh key to that user account from ~/.ssh/id\_rsa.pub. 
  2. Installs Java, tmux, ctags and the "Developer Tools" RPM
  3. Installs [virtualenvburrito](https://github.com/brainsik/virtualenv-burrito)
  4. Installs [rvm](http://rvm.io/)
  5. Installs [Luke's flavor of VIM](https://github.com/lukecampbell/vim-folder/)

- ERDDAP (erddap): Use this role for deployments that need ERDDAP
  1. Installs nginx through yum
  2. Sets up, downloads and installs tomcat to /var/tomcats/apache-tomcat-7.0.56
     1. Configures server.xml
     2. Configures setenv.sh
     3. Installs init.d script
  3. Installs ERDDAP
     1. Downloads and installs fonts for ERDDAP
     2. Download and installs the ERDDAP WAR file
     3. Download and configures the setup.xml file based on a JINJA template
     4. Creates a launch point at /scratch/erddap for ERDDAP to put stuff in

- netCDF (netcdf): netCDF can sometimes be a pain with all of its dependencies.
  This role should be used on deployments where netCDF libraries are used and
  or needed.
  1. Installs HDF5 from RPM
  2. Downloads and installs the netcdf4 source code to the /usr/local prefix

- Web Development (web): Use this role for deployments that host web development projects
  1. Installs nginx
  2. Sets up nginx account
  3. Installs nodeJS
  4. Configures nginx from a template


Playbooks
===

Every playbook comes with the Python 2.7 role

- Developer (dev.yml): The developer playbook installs python 2.7 and the Developer role
- ERDDAP (erddap.yml): The ERDDAP playbook installs python, netCDF and ERDDAP
- Science Developer (sciencedev.yml): Installs Python and netCDF roles
- Tomcat (tomcatdev.yml): Installs just Tomcat
- Web Developer (web.yml): Installs Python 2.7, Developer and the Web roles

