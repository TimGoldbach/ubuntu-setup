#!/bin/bash
red=`tput setaf 1`
green=`tput setaf 2`
reset=`tput sgr0`

function menuMessage() {
  echo ""
  echo "[1] Install Standard Programs"
  echo -e "\tArduino IDE, Chrome, Discord, Insomnia, JetBrains Toolbox, Notion, Remmina, Slack, Spotify, VS Code, Zoom"
  echo ""

  echo "[2] Install WebDev Dependencies"
  echo -e "\tComposer, Git, MySql, nginx, nodejs, npm, PHP, PHPMyAdmin"
  echo ""

  echo "[3] Clone the important repositories"
  echo -e "\tClone all used Shopware Repos, the school Repos and the private Repos"
  echo -e "\t${red}For this script to work git must be installed. It is best to perform [2] first.${reset}"
  echo -e "\t${red}Keep in mind, that you need to log in into GitHub & GitLab manually.${reset}"
  echo ""

  read -p "Select your option [${green}1${reset}/${green}2${reset}/${green}3${reset}]: " input

  case $input in
    1)
      installStandardPrograms;;
    2)
      installWebDevDependencies;;
    3)
      cloneImportantGitRepositories;;
  esac

#  if [ $input -eq 1 ]; then
#    installStandardPrograms
#  fi
#
#  if [ $input -eq 2 ]; then
#    installWebDevDependencies
#  fi
#
#  if [ $input -eq 3 ]; then
#    cloneImportantGitRepositories
#  fi
}

function installStandardPrograms() {
  echo ""
  echo "${green}Installing standard programs...${reset}"
  echo ""

  sudo apt-get update -y
  sudo apt-get upgrade -y
  sudo apt-get autoremove --purge -y
  sudo apt-get install snapd -y

  echo ""
  echo "${green}Installing Arduino IDE...${reset}"
  echo ""
  sudo apt-get install arduino -y

  echo ""
  echo "${green}Installing Google Chrome...${reset}"
  echo ""
  sudo apt install ./google-chrome-stable_current_amd64.deb -y

  echo ""
  echo "${green}Installing Discord...${reset}"
  echo ""
  sudo snap install discord -y

  echo ""
  echo "${green}Installing Insomnia...${reset}"
  echo ""
  sudo apt-get install insomnia -y

  echo ""
  echo "${green}Installing JetBrains Toolbox...${reset}"
  echo ""
  sudo tar -xzf ideaIU.tar.gz -C /opt -y

  echo ""
  echo "${green}Installing Notion...${reset}"
  echo ""
  sudo snap install notion-snap -y

  echo ""
  echo "${green}Installing Remmina...${reset}"
  echo ""
  sudo snap install remmina -y

  echo ""
  echo "${green}Installing Slack...${reset}"
  echo ""
  sudo snap install slack -y

  echo ""
  echo "${green}Installing Spotify...${reset}"
  echo ""
  sudo snap install spotify -y

  echo ""
  echo "${green}Installing VS Code...${reset}"
  echo ""
  sudo snap install code --classic -y

  echo ""
  echo "${green}Installing Zoom...${reset}"
  echo ""
  sudo snap install zoom-client -y

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
  echo "${green}Installing composer...${reset}"
  echo ""
  sudo apt-get install composer -y

  echo ""
  echo "${green}Installing git...${reset}"
  echo ""
  sudo apt-get install git -y
  sudo gh auth

  echo ""
  echo "${green}Installing MySql...${reset}"
  echo ""
  sudo apt-get install mysql -y

#  sudo wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg
#  sudo sh -c 'echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list'
#  sudo apt-get update
#  sudo apt-get install php8.0 php8.0-cli php8.0-cgi php8.0-fpm php8.0-gd php8.0-mysql php8.0-imap php8.0-curl php8.0-intl php8.0-pspell php8.0-sqlite3 php8.0-tidy php8.0-xsl php8.0-zip php8.0-mbstring php8.0-soap php8.0-opcache php8.0-common php8.0-readline php8.0-xml -y

  menuMessage
}

function cloneImportantGitRepositories() {
  echo ""
  echo "${green}Cloning the important repositories...${reset}"
  echo ""

  mkdir projects && cd projects

  mkdir private

  mkdir school && cd school
  git clone https://github.com/relativvv/GrammatickMietTiedemann.git
  cd ..

  mkdir shopware && cd shopware
  git clone https://gitlab.shopware.com/T.Goldbach/tkitchenimplementation.git
  mkdir cloud && cd cloud
  git clone https://gitlab.shopware.com/shopware/6/product/development.git
  git checkout platform-fork
  rm -rf platform
  git clone https://gitlab.shopware.com/shopware/6/product/platform.git
  cd platform
  git checkout platform-fork
  cd ../custom/plugins
  git clone https://gitlab.shopware.com/shopware-cloud/rufus.git
  cd ../../../../..
  git clone https://gitlab.shopware.com/product/handbook.git
  git clone https://gitlab.shopware.com/shopware/6/product/development.git
  cd development
  rm -rf platform
  git clone https://gitlab.shopware.com/shopware/6/product/platform.git
  cd ../..

  mkdir setup
#  git clone (this)

  menuMessage
}

menuMessage

done
