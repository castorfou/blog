echo "configure docker v1"

. /etc/lsb-release
# add APT docker.list
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
echo "deb [arch=amd64] https://artifactory.michelin.com/artifactory/ubuntu-docker-remote" $DISTRIB_CODENAME "stable" | sudo tee /etc/apt/sources.list.d/docker.list
# nvidia docker
distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add -
curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | sudo tee /etc/apt/sources.list.d/nvidia-docker.list
sudo apt update

source /etc/os-release
sudo apt install -y docker-ce docker-ce-cli containerd.io nvidia-container-toolkit
sudo usermod -aG docker $USER
sudo service docker start
sudo curl -L "https://github.com/docker/compose/releases/download/v2.11.2/docker-compose-linux-x86_64" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose