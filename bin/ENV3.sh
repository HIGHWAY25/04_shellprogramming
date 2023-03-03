#!/bin/bash

. /root/bin/functions.sh

# 1) telnet server
echo "##### TELNET Server #####"
PkgInst "telnet telnet-server"
SvcEnable "telnet.socket"
# 2) ftp server
echo "##### FTP Server #####"
PkgInst "vsftpd ftp"
VsFtpConf 
SvcEnable "vsftpd.service"
# 3) ssh server
echo "##### SSH Server #####"
PkgInst "openssh-server openssh-clients openssh"
SshConf
SvcEnable "sshd.service"
# 4) nginx web server
echo "##### NGINX Server #####"
CheckWebSvc "nginx"
PkgInst "nginx"
NginxConf
SvcEnable "nginx.service"