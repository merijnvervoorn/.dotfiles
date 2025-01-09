#! /bin/bash

# Colours
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
RESET='\033[0m'

log_start() {
    echo -e "${CYAN}····················································${RESET}"
}

log_end() {
    echo -e "${CYAN}····················································${RESET}"
    echo
    echo
    echo
    echo
    echo
    tput cup $(stty size|awk '{print int($1-5);}') 0 && tput ed
}

uninstall() {
    log_start
    echo -e "${YELLOW}Uninstalling unnecessary packages...${RESET}"
    
    sudo rm /usr/share/applications/thunderbird.desktop
    sudo rm /usr/share/applications/org.gnome.Totem.desktop
    sudo rm /usr/share/applications/org.gnome.Shotwell-Viewer.desktop
    sudo rm /usr/share/applications/org.gnome.Shotwell.desktop
    sudo rm /usr/share/applications/org.gnome.Shotwell.Auth.desktop
    sudo rm /usr/share/applications/org.gnome.seahorse.Application.desktop
    sudo rm /usr/share/applications/org.gnome.Evolution-alarm-notify.desktop
    sudo rm /usr/share/applications/org.gnome.evolution-data-server.OAuth2-handler.desktop
    sudo rm /usr/share/applications/org.gnome.clocks.desktop
    sudo rm /usr/share/applications/org.gnome.Calendar.desktop
    
    sudo apt autoremove --purge
    
    echo -e "${GREEN}Done installing essentials!${RESET}"
    log_end
}

install_essentials() {
    log_start
    echo -e "${YELLOW}Installing essentials...${RESET}"
    
    # Installing command-line utilities
    sudo apt install curl wget neofetch samba
    
    # Update
    sudo apt update && sudo apt upgrade -y
    
    # Apt
    sudo apt install -y audacity calibre firefox gimp git gnome-tweaks gnome-shell-extensions kdenlive libreoffice onedrive python3 python3-pip vlc 
    
    # Removing the office applications I don't need
    sudo rm /usr/share/applications/libreoffice-draw.desktop
    sudo rm /usr/share/applications/libreoffice-base.desktop
    sudo rm /usr/share/applications/libreoffice-math.desktop
    
    # Snap
    sudo snap install discord spotify
    
    #Internet
    sudo add-apt-repository -y ppa:obsproject/obs-studio
    sudo apt install -y ffmpeg obs-studio
    
    wget -q --content-disposition -O code_latest.deb "https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64"
    sudo apt install -y ./code_latest.deb
    rm -f code_latest.deb
    echo -e "${GREEN}Done installing essentials!${RESET}"
    log_end
}

install_extras() {
    log_start
    echo -e "${YELLOW}Installing extras...${RESET}"
    
    # Apt
    sudo apt install -y steam virtualbox
    
    #Tailscale and EduVPN
    curl -fsSL https://tailscale.com/install.sh | sh
    curl --proto '=https' --tlsv1.2 https://docs.eduvpn.org/client/linux/install.sh -O
    bash ./install.sh
    
    # Iriun
    DOWNLOAD_URL=$(curl -s https://iriun.gitlab.io/ | grep -oP 'iriunwebcam-\d+\.\d+\.\d+\.deb' | head -n 1)

    if [ -z "$DOWNLOAD_URL" ]; then
        echo "Error: Unable to find the latest .deb link!"
        exit 1
    fi

    # Full URL to download
    DEB_URL="https://iriun.gitlab.io/$DOWNLOAD_URL"

    # Download the latest .deb package
    echo "Downloading the latest Iriun Webcam package from $DEB_URL..."
    wget -O iriunwebcam.deb $DEB_URL

    # Install the .deb package
    echo "Installing Iriun Webcam..."
    sudo dpkg -i iriunwebcam.deb

    # Fix any missing dependencies (if required)
    sudo apt-get install -f

    # Clean up
    rm iriunwebcam.deb
    
    # Lutris
    # URL of the Lutris GitHub releases page
    GITHUB_RELEASES_URL="https://github.com/lutris/lutris/releases"

    # Fetch the latest release version and package URL from GitHub
    LATEST_RELEASE=$(curl -s $GITHUB_RELEASES_URL | grep -oP 'lutris_\d+\.\d+\.\d+_all\.deb' | head -n 1)

    if [ -z "$LATEST_RELEASE" ]; then
        echo "Error: Unable to find the latest .deb link!"
        exit 1
    fi

    # Full URL to download
    DEB_URL="https://github.com/lutris/lutris/releases/download/v0.5.18/$LATEST_RELEASE"

    # Download the latest Lutris .deb package
    wget -O lutris.deb $DEB_URL

    # Install the .deb package
    sudo dpkg -i lutris.deb

    # Fix any missing dependencies (if required)
    sudo apt-get install -f

    # Clean up
    rm lutris.deb
        
    echo -e "${GREEN}Done installing extras!${RESET}"
    log_end
}

brave() {
    log_start
    echo -e "${YELLOW}Installing Brave...${RESET}"
    curl -fsS https://dl.brave.com/install.sh | sh
    echo -e "${GREEN}Brave installed!${RESET}"
    log_end
}

verify_installs() {
    log_start
    echo -e "${YELLOW}Verifying installations...${RESET}"
    apt_programs=(audacity calibre firefox gimp git gnome-tweaks gnome-shell-extensions kdenlive libreoffice onedrive python3 python3-pip vlc)
    snap_programs=(discord spotify)

    for program in "${apt_programs[@]}"; do
        if ! dpkg -l | grep -q "$program"; then
            echo "$program is NOT installed."
        fi
    done

    for program in "${snap_programs[@]}"; do
        if ! snap list | grep -q "$program"; then
            echo "$program is NOT installed."
        fi
    done
    echo -e "${GREEN}Done verifying!${RESET}"
    log_end
}

updater() {
    log_start
    echo -e "${YELLOW}Updating all installed applications...${RESET}"
    sudo apt update && sudo apt upgrade -y
    snap refresh
    sudo apt-get dist-upgrade -y
    echo -e "${GREEN}Everything updated!${RESET}"
    log_end
}

cleanup() {
    log_start
    echo -e "${YELLOW}Cleaning up the mess from all those installs...${RESET}"
	sudo apt autoremove -y && sudo apt autoclean -y
	echo -e "${GREEN}Fully cleaned up!${RESET}"
    log_end
}

tailscale() {
    log_start
    echo -e "${BLUE}Setting up Tailscale (You might need to login yourself)...${RESET}"
    sudo tailscale up
    echo -e "${GREEN}Tailscale running!${RESET}"
    log_end
}

git_global() {
    log_start
    echo -e "${BLUE}Setting Git username and email...${RESET}"
	git config --global user.name "merijnvervoorn"
	git config --global user.email "161606054+merijnvervoorn@users.noreply.github.com"
	git config --global credential.helper store
	echo -e "${GREEN}Git username and email set!${RESET}"
    log_end
}

dotfiles() {
    log_start
    echo -e "${BLUE}Setting up dotfiles...${RESET}"
    
    # Clone git and add symlinks
    cd ~
    git clone https://github.com/merijnvervoorn/.dotfiles
    bash /.dotfiles/symlink.sh
    
    #Setup settings
    wget -qO /tmp/savedesktop-native-installer.py https://raw.githubusercontent.com/vikdevelop/SaveDesktop/main/native/native_installer.py && python3 /tmp/savedesktop-native-installer.py --install
    ~/.local/bin/savedesktop --import-config ~/.dotfiles/savedesktop.sd.tar.gz
    wget -qO /tmp/savedesktop-native-installer.py https://raw.githubusercontent.com/vikdevelop/SaveDesktop/main/native/native_installer.py && python3 /tmp/savedesktop-native-installer.py --remove
    
    echo -e "${GREEN}Dotfiles in use!${RESET}"
    log_end
}

ask() {
    local prompt="$1"
    local response
    while true; do
        read -p "   $prompt [y|n] " response
        case $response in
            [Yy]*) return 0 ;;
            [Nn]*) return 1 ;;  
            *) echo -e "${RED}Please answer Yes (y) or No (n).${RESET}" ;;
        esac
    done
}

main() {
    clear
    echo
    echo -e "${GREEN}   ····················································${RESET}"
    echo -e "${GREEN}      █████        ███                               ${RESET}"
    echo -e "${GREEN}     ░░███        ░░░                                ${RESET}"
    echo -e "${GREEN}      ░███        ████  ████████   █████ ████  █████ ${RESET}"
    echo -e "${GREEN}      ░███       ░░███ ░░███░░███ ░░███ ░███  ███░░  ${RESET}"
    echo -e "${GREEN}      ░███        ░███  ░███ ░███  ░███ ░███ ░░█████ ${RESET}"
    echo -e "${GREEN}      ░███      █ ░███  ░███ ░███  ░███ ░███  ░░░░███${RESET}"
    echo -e "${GREEN}      ███████████ █████ ████ █████ ░░████████ ██████ ${RESET}"
    echo -e "${GREEN}     ░░░░░░░░░░░ ░░░░░ ░░░░ ░░░░░   ░░░░░░░░ ░░░░░░  ${RESET}"
    echo -e "${GREEN}   ····················································${RESET}"
    echo -e "${GREEN}   :Linux Installation and Navigation of User Software:${RESET}"
    echo -e "${GREEN}   ····················································${RESET}"
    echo -e "${CYAN}                                               By Merijn${RESET}"

    if ask "Do you want to uninstall the unnecessary packages?"; then
        uninstall
        echo
    fi
    
    if ask "Do you want to install essential applications?"; then
        install_essentials
        echo
        
        if ask "Do you also want to install extra applications?"; then
            install_extras
        fi
        echo
        if ask "How about a second browser (Brave)?"; then
            brave
        fi
        verify_installs
    fi
    echo
    if ask "Do you want to update the applications?"; then
        updater
    fi
    echo
    if ask "Do you want to clean up the system (remove unnecessary packages)?"; then
        cleanup
    fi
    echo
    if ask "Do you want to set up tailscale?"; then
        tailscale
    fi
    echo
    if ask "Do you want to configure Git globally?"; then
        git_global
    fi
    echo
    
    if ask "Do you want to set up your dotfiles? (Make sure to get a Persoanl Access Token from Github for logging in)"; then
        dotfiles
    fi
    echo    
    
    
    #if ask "question"; then
    #   function
    #fi
    #echo
    

    echo -e "   ${GREEN}··························································${RESET}"
    echo -e "   ${GREEN}:░█░░░▀█▀░█▀█░█░█░█▀▀░░░█▀▀░█▀█░█▄█░█▀█░█░░░█▀▀░▀█▀░█▀▀░█:${RESET}"
    echo -e "   ${GREEN}:░█░░░░█░░█░█░█░█░▀▀█░░░█░░░█░█░█░█░█▀▀░█░░░█▀▀░░█░░█▀▀░▀:${RESET}"
    echo -e "   ${GREEN}:░▀▀▀░▀▀▀░▀░▀░▀▀▀░▀▀▀░░░▀▀▀░▀▀▀░▀░▀░▀░░░▀▀▀░▀▀▀░░▀░░▀▀▀░▀:${RESET}"
    echo -e "   ${GREEN}··························································${RESET}"
    echo
    sleep 5
    neofetch
}

main
