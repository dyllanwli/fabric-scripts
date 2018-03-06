#!/usr/bin/env bash
set -e
CURRENT="$(dirname $(readlink -f ${BASH_SOURCE}))"

fcn=$1

systemProfile="/etc/profile"

function golang() {
    goTar=go1.9.2.linux-amd64.tar.gz
    if go version >/dev/null;then
        echo ... to overwrite exiting golang at GOROOT: $(go env GOROOT)
        sudo rm -rf $(go env GOROOT)
    fi
	# install golang
	if docker version >/dev/null ;then
        goTar=$(docker version | grep -m1 go| awk '{print($3)}').linux-amd64.tar.gz
        echo ... to use docker inline go version :[${goTar}]
    fi
	wget https://redirector.gvt1.com/edgedl/go/${goTar}
	sudo tar -C /usr/local -xzf ${goTar}
	# write path to 'go' command
	if ! grep "/usr/local/go/bin" $systemProfile; then
		echo "export PATH=\$PATH:/usr/local/go/bin" | sudo tee -a $systemProfile
	fi
	# write path to $GOPATH/bin
	GOPATH=$(go env GOPATH)
	if ! grep "$GOPATH/bin" $systemProfile; then
		echo "export PATH=\$PATH:$GOPATH/bin" | sudo tee -a $systemProfile
	fi
	# delete install pack
	rm -f ${goTar}
}
function golang-uninstall() {
	# TODO  To remove an existing Go installation from your system delete the go directory. 
    # This is usually /usr/local/go under Linux, Mac OS X, and FreeBSD
	# You should also remove the Go bin directory from your PATH environment variable. 
    # Under Linux and FreeBSD you should edit /etc/profile or $HOME/.profile. 
    # If you installed Go with the Mac OS X package then you should remove the /etc/paths.d/go file. 
}


function nodejs(){
	echo "===== Install nvm ====="
	curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.8/install.sh | bash

	echo "===== Add those below to you ~/.bashrc. then run source ===== "
	echo " "
	echo "export NVM_DIR=\"\$HOME/.nvm"
	echo " [ -s \"\$NVM_DIR/nvm.sh\" ] && \. \"\$NVM_DIR/nvm.sh\" # This loads nvm"
	command -v nvm
}
if [ -n "$fcn" ]; then
	$fcn
	nodejs
else
	"Nothing to do. end. "
fi