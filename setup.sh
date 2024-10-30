#!/bin/bash
download_oh_my_zsh() {
    cd ~
    wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh
    chmod +x install.sh
    #Run in a process
    ./install.sh &
    #Wait for it to finish
    wait

    rm -f install.sh
}

download_plugins() {
    local ZSH_CUSTOM=~/.oh-my-zsh/custom
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
    git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
    git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git $ZSH_CUSTOM/plugins/fast-syntax-highlighting
}

edit_plugins() {
    #Find the entire line for plugins=(git)
    #Replace it wiht plugins=(git zsh-autosuggestions zsh-syntax-highlighting fast-syntax-highlighting)
    sed -i 's/^plugins=(git)$/plugins=(git zsh-autosuggestions zsh-syntax-highlighting fast-syntax-highlighting)/' ~/.zshrc

}

edit_theme() {
    #Find the entire line for ZSH_THEME="robbyrussell"
    #Replace it with ZSH_THEME="powerlevel10k/powerlevel10k"
    sed -i 's/^robyrussell$/"powerlevel10k\/powerlevel10k/' ~/.zshrc
}

edit_history_size() {
    sed -i '/^HISTFILESIZE=/d' ~/.zshrc
    sed -i '/^HISTSIZE=/d' ~/.zshrc
    echo 'export HISTFILESIZE=9999999999' >> ~/.zshrc
    echo 'export HISTSIZE=9999999999' >> ~/.zshrc
    
}

main() {
    download_oh_my_zsh
    download_plugins
    edit_plugins
    edit_theme
    edit_history_size
}

main
