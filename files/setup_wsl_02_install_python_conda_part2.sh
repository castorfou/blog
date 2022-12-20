echo "install mamba v1"
# https://stackoverflow.com/questions/72103046/libtinfo-so-6-no-version-information-available-message-using-conda-environment
conda install -y -c conda-forge ncurses

conda install -y mamba -n base -c conda-forge
mamba init

if [ -z "${REQUESTS_CA_BUNDLE}" ]; then 
tee -a ~/.bashrc << EOF
export REQUESTS_CA_BUNDLE=/etc/ssl/certs/ca-certificates.crt
EOF
fi

sudo apt install -y nodejs npm

# to launch browser after starting jupyter
#jupyter notebook --generate-config
#mkdir -p ~/.jupyter
#echo 'c.NotebookApp.use_redirect_file = False' >> ~/.jupyter/jupyter_notebook_config.py


tee -a ~/.bashrc << EOF
export PATH="/mnt/c/Program Files/Google/Chrome/Application:$PATH"
export BROWSER='chrome.exe'
EOF


if [ -e "/.cfg" ]; then
		config='/usr/bin/git --git-dir=/.cfg/ --work-tree=/'
		$config add ~/.bashrc
		$config commit -m'export certificates for conda, and conda as mamba'
#		$config add ~/.jupyter/jupyter_notebook_config.py
#		$config commit -m'launch browser with jupyter'
		$config push		
		
fi

