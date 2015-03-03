#!/bin/bash

KVER=`uname -a`
# Variable to know if Homebrew should be installed
MSFPASS=`openssl rand -hex 16`
#Variable with time of launch used for log names
NOW=$(date +"%d-%y-%H_%M_%S")
IGCC=1
INSTALL=1
REMOVE=1

function print_good ()
{
echo -e "\x1B[01;32m[*]\x1B[0m $1"
}
########################################
function print_error ()
{
echo -e "\x1B[01;31m[*]\x1B[0m $1"
}
########################################
function print_status ()
{
echo -e "\x1B[01;34m[*]\x1B[0m $1"
}
########################################
function check_root
{
if [ "$(id -u)" != "0" ]; then
print_error "This step must be ran as root"
exit 1
fi
}
########################################
function Remove_all ()
{
echo "Remove_all function"
}
########################################
function usage ()
{
echo "Ubuntu PwnBox!"
echo "By DarkR4y[at]Blackh4t.org"
echo "Ver 0.0.1"
echo ""
echo "-i: Install now."
echo "-r: Remove all the tools."
echo "-u: Update all the tools."
echo "-h: This help message."
}



#### MAIN ###

[[ ! $1 ]] && { usage; exit 0; }
#Variable with log file location for trobleshooting
LOGFILE="/tmp/pwnbox_installer_$NOW.log"
while getopts "irp:h" options; do
case $options in
i ) INSTALL=0;;
h ) usage;;
r ) REMOVE=0;;
#u ) MSFPASS=$OPTARG;;
\? ) usage
exit 1;;
* ) usage
exit 1;;
esac
done

if [[ $REMOVE -eq 0 ]]; then
Remove_all
fi

if [ $INSTALL -eq 0 ]; then
print_status "Log file with command output and errors $LOGFILE"

print_status "###################################################################"
elif [[ "$KVER" =~ buntu ]] || [ -f /etc/dpkg/origins/ubuntu ]; then
install_deps_deb
install_nmap_linux
configure_psql_deb
install_msf_linux
install_plugins_linux
install_armitage_linux
print_status "##################################################################"
print_status "### YOU NEED TO RELOAD YOUR PROFILE BEFORE USE OF METASPLOIT! ###"
print_status "### RUN source ~/.bashrc ###"
print_status "##################################################################"
else
print_error "The script does not support this platform at this moment."
exit 1
fi
