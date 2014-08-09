MiServerDeploy
==============

#WARNING:
**This is still under development and some parts may not work correctly.
All of this system is subject to change at this time.**


GitHub deployment server for MiServer

This code runs within MiServer2 (https://github.com/Dyalog/MiServer/tree/MiServer2)
it will be ported to MiServer3 as soon as it is available.

##Setup the Payload server

Make sure you have the latest version of MiServer2:

For the sake of this, I will assume we're going to use /MiServer/MiDeploy

### Setup users:
```Shell
useradd misite  # User we'll run our actual site as
useradd payload # user to run the payload server (this stuff)
```
### Get the code
```Shell
cd /
# Download MiServer
git clone https://github.com/Dyalog/MiServer.git

cd /MiServer

# use MiServer2
git checkout MiServer2

# get the payload server

git clone https://github.com/JasonRivers/MiServerDeploy.git MiDeploy

#Set the permissions
cd /
chown -R misite:misite /MiServer
chown -R payload:payload /MiServer/MiDeploy
```

### Add user info to sudoers file
This allows us to run the shell scripts as other users from the payload server
without a password

```
payload ALL=(miserver) NOPASSWD: /MiServer/MiDeploy/DeployScripts/gitPull.sh
payload ALL=(root) NOPASSWD: /MiServer/MiDeploy/DeployScripts/restartService.sh
payload ALL=(root) NOPASSWD: /MiServer/MiDeploy/DeployScripts/restartServer.sh
```

### Setup the Payload Server

Edit /MiServer/MiDeploy/index.dyalog
You'll want to set the following variables near the top of the file:

Variable | what for
---------|----------
**ServiceUser** | The user your want your git pulls to run as (Generally the same user as your web service)
**GitHubBranch** | The Branch you wish to check for pushes against (Default is Staging)
**GitHubRepository**  | The disk location of your website clone from Github (EG /MiServer/MiSite)
**PayloadDirectory**  | The directory that this payload server is in (default /MiServer/MiDeploy)

### Configure Github Webhooks 

From the Github Website select your repository and then settings -> Webhooks
type the URL of your payload server ( http://123.123.123.123:7654 )
Don't forget the port, The default port is 7654 and can be changed in $REPO/Config/Server.xml

### Test it out

```Shell
sudo su payload
cd /MiServer
MiServer='MiDeploy' dyalog ./mserver.dws
```

##WARNING:
If you chose to reboot the server, make sure you have a way of starting this service at system startup.
