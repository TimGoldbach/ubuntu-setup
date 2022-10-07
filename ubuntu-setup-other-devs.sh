#!/bin/bash
red=`tput setaf 1`
green=`tput setaf 2`
yellow=`tput setaf 3`
reset=`tput sgr0`
ubuntu_version=$(lsb_release -r -s)

function initialCall() {
    echo ""
    read -p "How "
    echo ""
}

function menuMessage() {
  echo ""
  echo "[1] Install OhMyZsh"
  echo ""

  echo ""
  echo "[2] Install all Standard Programs"
  echo -e "\tChrome, Discord, Insomnia, JetBrains Toolbox, Notion, Remmina, Slack, Spotify, VS Code, Zoom"
  echo ""

  echo ""
  echo "[3] Install all Standard Programs, but ask before every installation"
  echo -e "\tChrome, Discord, Insomnia, JetBrains Toolbox, Notion, Remmina, Slack, Spotify, VS Code, Zoom"
  echo ""

  echo ""
  echo "[4] Install all WebDev Dependencies"
  echo -e "\tComposer, Git, MySql, nginx, nodejs, npm, Devenv, PHP"
  echo ""

  echo ""
  echo "[5] Install all WebDev Dependencies, but ask before evert installation"
  echo -e "\tComposer, Git, MySql, nginx, nodejs, npm, Devenv, PHP"
  echo ""

  echo ""
  echo -e "[6] Clone the shopware platform repository ${yellow}!!!BETA!!!${reset}"
  echo -e "\t${yellow}For this script to work git must be installed. It is best to perform [4]/[5] first.${reset}"
  echo -e "\t${yellow}Keep in mind, that you need to log in into GitHub & GitLab manually.${reset}"
  echo ""

  echo ""
  echo -e "[7] Clone the sbp repository ${yellow}!!!BETA!!!${reset}"
  echo -e "\t${yellow}For this script to work git must be installed. It is best to perform [4]/[5] first.${reset}"
  echo -e "\t${yellow}Keep in mind, that you need to log in into GitHub & GitLab manually.${reset}"
  echo ""

  read -p "Select your option [${green}1${reset}/${green}2${reset}/${green}3${reset}/${green}4${reset}/${green}5${reset}/${yellow}6${reset}/${yellow}7${reset}]: " input

  case $input in
    1)
      installOhMyZsh;;
    2)
      installStandardProgramsAll;;
    3)
      installStandardPrograms;;
    4)
      installWebDevDependenciesAll;;
    5)
      installWebDevDependencies;;
    6)
      cloneShopware;;
    7)
      cloneSbp;;
  esac
}

function installOhMyZsh() {
    echo ""
    echo "${green}Installing OhMyZsh...${reset}"
    echo ""
    sudo apt-get install zsh -y
    sudo passwd root
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
}

function installStandardPrograms() {
  echo ""
  echo "${green}Installing standard programs...${reset}"
  echo ""

  sudo apt-get update -y
  sudo apt-get upgrade -y
  sudo apt-get autoremove --purge -y
  sudo apt-get install snapd -y
  sudo apt-get install curl gpg

  if [[ $ubuntu_version == "20.04" ]]; then
    curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
    sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/microsoft.gpg] https://packages.microsoft.com/ubuntu/20.04/prod focal main" > /etc/apt/sources.list.d/microsoft-ubuntu-focal-prod.list'
    sudo rm microsoft.gpg
  elif [[ $ubuntu_version == "22.04" ]]; then
    curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
    sudo install -o root -g root -m 644 microsoft.gpg /usr/share/keyrings/
    sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/microsoft.gpg] https://packages.microsoft.com/ubuntu/22.04/prod jammy main" > /etc/apt/sources.list.d/microsoft-ubuntu-jammy-prod.list'
    sudo rm microsoft.gpg
  fi

  sudo apt-get update
  sudo apt-get install intune-portal

  echo ""
  read -p  "${green}Do you want Terminal tooling to be installed? [yes/no]${reset}" input
  echo ""

  case $input in
    "yes" | "y")
      echo ""
      echo "${green}Installing Terminal tooling...${reset}"
      echo ""
      sudo apt-get install nano -y
      sudo apt-get install vim -y
    ;;
    "no" | "n")
    ;;
  esac

  echo ""
  read -p  "${green}Do you want Google Chrome to be installed? [yes/no]${reset}" input
  echo ""

  case $input in
    "yes" | "y")
      echo ""
      echo "${green}Installing Google Chrome...${reset}"
      echo ""
      sudo snap install chromium
    ;;
    "no" | "n")
    ;;
  esac

  echo ""
  read -p  "${green}Do you want Discord to be installed? [yes/no]${reset}" input
  echo ""

  case $input in
    "yes" | "y")
      echo ""
      echo "${green}Installing Discord...${reset}"
      echo ""
      sudo snap install discord
    ;;
    "no" | "n")
    ;;
  esac

  echo ""
  read -p  "${green}Do you want Insomnia to be installed? [yes/no]${reset}" input
  echo ""

  case $input in
    "yes" | "y")
      echo ""
      echo "${green}Installing Insomnia...${reset}"
      echo ""
      sudo snap install insomnia
    ;;
    "no" | "n")
    ;;
  esac

  echo ""
  read -p  "${green}Do you want JetBrains Toolbox to be installed? [yes/no]${reset}" input
  echo ""

  case $input in
    "yes" | "y")
      echo ""
      echo "${green}Installing JetBrains Toolbox...${reset}"
      echo ""
      sudo apt-get install libfuse2 -y
      cd /home/$USER/Downloads/
      sudo wget https://download.jetbrains.com/toolbox/jetbrains-toolbox-1.28.1.15219.tar.gz
      sudo tar -xzf jetbrains-toolbox-1.28.1.15219.tar.gz -C /opt
      cd
    ;;
    "no" | "n")
    ;;
  esac

  echo ""
  read -p  "${green}Do you want Notion to be installed? [yes/no]${reset}" input
  echo ""

  case $input in
    "yes" | "y")
      echo ""
      echo "${green}Installing Notion...${reset}"
      echo ""
      sudo apt-get install notion -y
    ;;
    "no" | "n")
    ;;
  esac

  echo ""
  read -p  "${green}Do you want Remmina to be installed? [yes/no]${reset}" input
  echo ""

  case $input in
    "yes" | "y")
      echo ""
      echo "${green}Installing Remmina...${reset}"
      echo ""
      sudo snap install remmina
    ;;
    "no" | "n")
    ;;
  esac

  echo ""
  read -p  "${green}Do you want Slack to be installed? [yes/no]${reset}" input
  echo ""

  case $input in
    "yes" | "y")
      echo ""
      echo "${green}Installing Slack...${reset}"
      echo ""
      sudo snap install slack
    ;;
    "no" | "n")
    ;;
  esac

  echo ""
  read -p  "${green}Do you want Spotify to be installed? [yes/no]${reset}" input
  echo ""

  case $input in
    "yes" | "y")
      echo ""
      echo "${green}Installing Spotify...${reset}"
      echo ""
      sudo snap install spotify
    ;;
    "no" | "n")
    ;;
  esac

  echo ""
  read -p  "${green}Do you want VS Code to be installed? [yes/no]${reset}" input
  echo ""

  case $input in
    "yes" | "y")
      echo ""
      echo "${green}Installing VS Code...${reset}"
      echo ""
      sudo snap install code --classic
    ;;
    "no" | "n")
    ;;
  esac

  echo ""
  read -p  "${green}Do you want Zoom to be installed? [yes/no]${reset}" input
  echo ""

  case $input in
    "yes" | "y")
      echo ""
      echo "${green}Installing Zoom...${reset}"
      echo ""
      sudo snap install zoom-client
    ;;
    "no" | "n")
    ;;
  esac

  echo ""
#    read -p  "${green}Do you want ${red}Admin by Request ${green} to be installed? [yes/no]${reset}" input
  echo "${green}Do you want ${red}Admin by Request ${green} to be installed? [yes/no]${reset}"
  echo "${red}Aware: Currently not working correctly!${reset}"
  echo ""

  case $input in
    "yes" | "y")
      echo ""
      echo "${green}Installing Admin by Request...${reset}"
      echo ""
      echo "${red}Aware: Currently not working correctly!${reset}"
#        sudo apt-get install libfuse2 -y
#        curl -u "itabffep:Bb$r%JY02cC2" ftp://cloud6-vm266.de-nserver.de/www.it-assets.shopware.com/adminbyrequest/abr-installer2.2 -o "$USER_HOME/Downloads/abr-installer2.2"
#        sudo chmod +x "$USER_HOME/Downloads/abr-installer2.2"
#        sudo -u "$USER" "$USER_HOME/Downloads/abr-installer2.2"
    ;;
    "no" | "n")
    ;;
  esac

  echo ""
  echo "${green}The chosen standard programs have been installed.${reset}"
  echo ""

  menuMessage
}

function installStandardProgramsAll () {
  sudo apt-get update -y
  sudo apt-get upgrade -y
  sudo apt-get autoremove --purge -y
  sudo apt-get install snapd -y
  sudo apt-get install curl gpg

  if [[ $ubuntu_version == "20.04" ]]; then
    curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
    sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/microsoft.gpg] https://packages.microsoft.com/ubuntu/20.04/prod focal main" > /etc/apt/sources.list.d/microsoft-ubuntu-focal-prod.list'
    sudo rm microsoft.gpg
  elif [[ $ubuntu_version == "22.04" ]]; then
    curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
    sudo install -o root -g root -m 644 microsoft.gpg /usr/share/keyrings/
    sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/microsoft.gpg] https://packages.microsoft.com/ubuntu/22.04/prod jammy main" > /etc/apt/sources.list.d/microsoft-ubuntu-jammy-prod.list'
    sudo rm microsoft.gpg
  fi

  sudo apt-get update
  sudo apt-get install intune-portal

  echo ""
  echo "${green}Installing Terminal tooling...${reset}"
  echo ""
  sudo apt-get install zsh -y
  sudo passwd root
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  sudo apt-get install nano -y
  sudo apt-get install vim -y

  echo ""
  echo "${green}Installing Google Chrome...${reset}"
  echo ""
  sudo snap install chromium

  echo ""
  echo "${green}Installing Discord...${reset}"
  echo ""
  sudo snap install discord

  echo ""
  echo "${green}Installing Insomnia...${reset}"
  echo ""
  sudo apt-get install insomnia

  echo ""
  echo "${green}Installing JetBrains Toolbox...${reset}"
  echo ""
  sudo apt-get install libfuse2 -y
  cd /home/$USER/Downloads/
  sudo wget https://download.jetbrains.com/toolbox/jetbrains-toolbox-1.28.1.15219.tar.gz
  sudo tar -xzf jetbrains-toolbox-1.28.1.15219.tar.gz -C /opt

  echo ""
  echo "${green}Installing Notion...${reset}"
  echo ""
  sudo apt-get install notion -y

  echo ""
  echo "${green}Installing Remmina...${reset}"
  echo ""
  sudo snap install remmina

  echo ""
  echo "${green}Installing Slack...${reset}"
  echo ""
  sudo snap install slack

  echo ""
  echo "${green}Installing Spotify...${reset}"
  echo ""
  sudo snap install spotify

  echo ""
  echo "${green}Installing VS Code...${reset}"
  echo ""
  sudo snap install code --classic

  echo ""
  echo "${green}Installing Zoom...${reset}"
  echo ""
  sudo snap install zoom-client

  echo ""
  echo "${green}Standard programs has been installed.${reset}"
  echo ""

  menuMessage
}

function installWebDevDependencies() {
  echo ""
  echo "${green}Installing WebDev dependencies...${reset}"
  echo ""

  sudo apt-get update -y
  sudo apt-get upgrade -y
  sudo apt-get autoremove --purge -y

  echo ""
  read -p  "${green}Do you want Composer to be installed? [yes/no]${reset}" input
  echo ""

  case $input in
    "yes" | "y")
      echo ""
      echo "${green}Installing Composer...${reset}"
      echo ""
      sudo apt-get install composer -y
    ;;
    "no" | "n")
    ;;
  esac

  echo ""
  read -p  "${green}Do you want Git to be installed? [yes/no]${reset}" input
  echo ""

  case $input in
    "yes" | "y")
      echo ""
      echo "${green}Installing Git...${reset}"
      echo ""
      sudo apt-get install git -y
    ;;
    "no" | "n")
    ;;
  esac

  echo ""
  read -p  "${green}Do you want a ssh-key to be generated and setup for you? [yes/no]${reset}" input
  echo ""

  case $input in
    "yes" | "y")
      echo ""
      echo "${green}Creating SSH-Key...${reset}"
      echo ""
      ssh-keygen -t rsa -b 4096
      echo ""
      echo "${yellow}Please copy the following public-key and use it to authorize yourself:${reset}"
      echo ""
      cat /home/$USER/.ssh/id_rsa.pub
    ;;
    "no" | "n")
    ;;
  esac

  echo ""
  read -p  "${green}Do you want MySql to be installed? [yes/no]${reset}" input
  echo ""

  case $input in
    "yes" | "y")
      echo ""
      echo "${green}Installing MySql...${reset}"
      echo ""
      sudo apt-get install mysql-server -y
    ;;
    "no" | "n")
    ;;
  esac

  echo ""
  read -p  "${green}Do you want Nginx to be installed? [yes/no]${reset}" input
  echo ""

  case $input in
    "yes" | "y")
     echo ""
     echo "${green}Installing Nginx...${reset}"
     echo ""
     sudo apt-get install nginx -y
    ;;
    "no" | "n")
    ;;
  esac

  echo ""
  read -p "${green}Do you want NodeJs to be installed? [yes/no]${reset}" input
  echo ""

  case $input in
    "yes" | "y")
     echo ""
     echo "${green}Installing NodeJs...${reset}"
     echo ""
     sudo apt-get install nodejs -y
    ;;
    "no" | "n")
    ;;
  esac

  echo ""
  read -p "${green}Do you want npm to be installed? [yes/no]${reset}" input
  echo ""

  case $input in
    "yes" | "y")
     echo ""
     echo "${green}Installing npm...${reset}"
     echo ""
     sudo apt-get install npm -y
    ;;
    "no" | "n")
    ;;
  esac

  echo ""
  read -p "${green}Do you want Devenv to be installed? [yes/no]${reset}" input
  echo ""

  case $input in
    "yes" | "y")
      echo ""
      echo "${green}Installing Devenv...${reset}"
      echo ""
      sh <(curl -L https://nixos.org/nix/install) --daemon
      nix-env -iA cachix -f https://cachix.org/api/v1/install
      cachix use devenv
    ;;
    "no" | "n")
    ;;
  esac

  echo ""
  read -p "${green}Do you want PHP to be installed? [yes/no]${reset}" input
  echo ""

  case $input in
    "yes" | "y")
      echo ""
      echo "${green}Installing PHP...${reset}"
      echo ""
      sudo wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg
      sudo sh -c 'echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list'
      sudo apt-get update
    ;;
    "no" | "n")
    ;;
  esac

  echo ""
#    read -p  "${green}Do you want ${red}Admin by Request ${green} to be installed? [yes/no]${reset}" input
  echo "${green}Do you want ${red}Admin by Request ${green} to be installed? [yes/no]${reset}"
  echo "${red}Aware: Currently not working correctly!${reset}"
  echo ""

  case $input in
    "yes" | "y")
      echo ""
      echo "${green}Installing Admin by Request...${reset}"
      echo ""
      echo "${red}Aware: Currently not working correctly!${reset}"
#        sudo apt-get install libfuse2 -y
#        curl -u "itabffep:Bb$r%JY02cC2" ftp://cloud6-vm266.de-nserver.de/www.it-assets.shopware.com/adminbyrequest/abr-installer2.2 -o "$USER_HOME/Downloads/abr-installer2.2"
#        sudo chmod +x "$USER_HOME/Downloads/abr-installer2.2"
#        sudo -u "$USER" "$USER_HOME/Downloads/abr-installer2.2"
    ;;
    "no" | "n")
    ;;
  esac

  menuMessage
}


function installWebDevDependenciesAll() {
  echo ""
  echo "${green}Installing WebDev dependencies...${reset}"
  echo ""

  sudo apt-get update -y
  sudo apt-get upgrade -y
  sudo apt-get autoremove --purge -y

  echo ""
  echo "${green}Installing composer...${reset}"
  echo ""
  sudo apt-get install composer -y

  echo ""
  echo "${green}Installing git...${reset}"
  echo ""
  sudo apt-get install git -y

  echo ""
  echo "${green}Installing MySql...${reset}"
  echo ""
  sudo apt-get install mysql-server -y

  echo ""
  echo "${green}Installing Nginx...${reset}"
  echo ""
  sudo apt-get install nginx -y

  echo ""
  echo "${green}Installing NodeJs...${reset}"
  echo ""
  sudo apt-get install nodejs -y

  echo ""
  echo "${green}Installing npm...${reset}"
  echo ""
  sudo apt-get install npm -y

  echo ""
  echo "${green}Installing Devenv...${reset}"
  echo ""
  sh <(curl -L https://nixos.org/nix/install) --daemon
  nix-env -iA cachix -f https://cachix.org/api/v1/install
  cachix use devenv

  echo ""
  echo "${green}Installing Php...${reset}"
  echo ""

  sudo wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg
  sudo sh -c 'echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list'

  menuMessage
}

function cloneShopware() {
  echo ""
  echo "${green}Creating shopware repository...${reset}"
  echo ""

  mkdir /home/$USER/projects/shopware

  echo ""
  echo "${green}Cloning shopware repository...${reset}"
  echo ""

  git clone git@gitlab.shopware.com:shopware/6/product/platform.git /home/$USER/projects/shopware
}

function cloneSbp() {
  echo ""
  echo "${green}Creating sbp repository...${reset}"
  echo ""

  mkdir /home/$USER/projects/sbp

  echo ""
  echo "${green}Cloning sbp repository...${reset}"
  echo ""

  git clone git@gitlab.shopware.com:operations/sbp/shopware-business-platform.git /home/$USER/projects/sbp
}

menuMessage

done
