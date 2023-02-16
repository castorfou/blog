#!/bin/bash

echo "1. setup wsl-vpnkit"
if grep -Fxq "wsl-vpnkit" ~/.profile
then
    # code if found
	echo "   wsl-vpnkit already setup"
else
    # code if not found
    # changed (Feb-16 23) to fix <3>WSL (8) ERROR: CreateProcessParseCommon:782: Failed to translate \\wsl.localhost
	echo 'wsl.exe -d wsl-vpnkit --cd /app service wsl-vpnkit status >/dev/null || wsl.exe -d wsl-vpnkit --cd /app service wsl-vpnkit start' >> ~/.profile
fi
wsl.exe -d wsl-vpnkit service wsl-vpnkit start
source ./.bashrc
echo

echo "2. create ssh key to copy to gitlab"
. /etc/lsb-release
if [ ! -e ".ssh/id_rsa.pub" ]; then
		ssh-keygen -t rsa -b 4096 -C "WSL2 ubuntu $DISTRIB_RELEASE"
		cat .ssh/id_rsa.pub
		echo "copy this content to gitlab > preferences > SSH Keys"
		read -p "Press any key to resume ..."
fi
echo

echo "3. update certificates"
if [ ! -n "$(grep "^gitlab.michelin.com " ~/.ssh/known_hosts)" ]; then ssh-keyscan gitlab.michelin.com >> ~/.ssh/known_hosts 2>/dev/null; fi
git clone git@gitlab.michelin.com:devops-foundation/devops_environment.git /tmp/devops_environment
sudo cp /tmp/devops_environment/certs/* /usr/local/share/ca-certificates/
sudo update-ca-certificates
rm -rf /tmp/devops_environment
if [ $DISTRIB_RELEASE == "22.04" ]
then
echo 'bug SSL with ubuntu 22.04 - https://bugs.launchpad.net/ubuntu/+source/openssl/+bug/1963834/comments/7'
sudo tee -a /etc/ssl/openssl.cnf << EOF
[openssl_init]
ssl_conf = ssl_sect

[ssl_sect]
system_default = system_default_sect

[system_default_sect]
Options = UnsafeLegacyRenegotiation
EOF
fi

tee -a ~/.bashrc << EOF
export OPENSSL_CONF=/etc/ssl/openssl.cnf
EOF
echo

echo "4. update apt sources with artifactory"
echo 'Acquire { http::User-Agent "Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:13.37) Gecko/20100101 Firefox/31.33.7"; };' | sudo tee /etc/apt/apt.conf.d/90globalprotectconf
sudo sed -i 's,http://archive.ubuntu.com/ubuntu,https://artifactory.michelin.com/artifactory/ubuntu-archive-remote,g' /etc/apt/sources.list
sudo sed -i 's,http://security.ubuntu.com/ubuntu,https://artifactory.michelin.com/artifactory/ubuntu-archive-remote,g' /etc/apt/sources.list
# added Feb-16 23 to patch patch the CVE-2022-41903 and CVE-2022-23251 :  https://dev.michelin.com/wsl2/fundamentals#-very-important-for-all-git-user-patch-the-cve---and-cve--
echo "deb [arch=amd64 trusted=yes] https://artifactory.michelin.com/artifactory/git-core-ubuntu/ $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/git-core.list
sudo apt update
sudo apt upgrade -y
echo

echo "5. setup LD_LIBRARY_PATH"
tee -a ~/.bashrc << EOF
export LD_LIBRARY_PATH=/usr/lib/wsl/lib
EOF
