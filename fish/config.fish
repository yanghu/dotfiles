# Path to your oh-my-fish.
set fish_path $HOME/.oh-my-fish

# Path to your custom folder (default path is ~/.oh-my-fish/custom)
#set fish_custom $HOME/dotfiles/oh-my-fish

# Load oh-my-fish configuration.
. $fish_path/oh-my-fish.fish

# Custom plugins and themes may be added to ~/.oh-my-fish/custom
# Plugins and themes can be found at https://github.com/oh-my-fish/
Theme 'agnoster'
Plugin 'theme'


set -x PYTHON_PATH ~/bin/python_files
#for docker
set -x DOCKER_HOST tcp://192.168.59.105:2375
#set -x DOCKER_CERT_PATH /Users/huey/.boot2docker/certs/boot2docker-vm
set -e DOCKER_TLS_VERIFY
set -e DOCKER_CERT_PATH
#set -x DOCKER_TLS_VERIFY 1

#for some vim plugin
set -x DYLD_FORCE_FLAT_NAMESPACE 1

set -x GOPATH /Users/huey/Repos/golang

function fish_title
echo huey@(hostname)
end
