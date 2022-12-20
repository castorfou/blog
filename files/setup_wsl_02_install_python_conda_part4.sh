echo "install base_jupyter environment v0"

source ~/miniconda/etc/profile.d/conda.sh
mamba create -y -n base_jupyter python=3.9
conda activate base_jupyter
mamba install -y -c conda-forge jupyterlab
jupyter labextension install jupyterlab-plotly
mamba install -y -c conda-forge jupyterlab_execute_time

jupyter-lab --generate-config
echo 'c.ServerApp.use_redirect_file = False' >> ~/.jupyter/jupyter_lab_config.py

mkdir -p ~/bin
tee -a ~/bin/jupyterlab << EOF
#!/bin/bash
cd ~
source ~/miniconda/etc/profile.d/conda.sh
conda activate base_jupyter
jupyter lab
EOF
chmod +x  ~/bin/jupyterlab

tee -a ~/.bashrc << EOF
export PATH="~/bin:$PATH"
EOF


if [ -e "/.cfg" ]; then
		config='/usr/bin/git --git-dir=/.cfg/ --work-tree=/'
		$config add ~/.jupyter/jupyter_lab_config.py
		$config commit -m'launch browser with jupyter'
		$config add ~/bin/jupyterlab
		$config commit -m'launch jupyterlab'
		$config add ~/.bashrc
		$config commit -m'export PATH for jupyterlab'		
		$config push				
fi

