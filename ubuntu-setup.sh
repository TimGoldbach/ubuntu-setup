#!/bin/bash
red=`tput setaf 1`
green=`tput setaf 2`
yellow=`tput setaf 3`
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
  echo "${green}Installing Terminal tooling...${reset}"
  echo ""
  sudo apt-get install zsh -y
  sudo passwd root
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  sudo apt-get install nano
  sudo apt-get install vim

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

  echo ""
  read -p "${yellow}Do you want the Cronjobs to be installed? [y/n]${reset}" input

  case $input in
      y)
        sudo crontab -l > cron_bkp
        sudo echo "* * * * * su tim -c '/bin/wallpaper.sh'" >> cron_tmp
        sudo echo "*/15 * * * * su tim -c '/bin/usage-analysis.sh'" >> cron_tmp
        sudo crontab cron_tmp
        sudo rm cron_tmp

        echo "${green}Cronjobs succesfully installed!${reset}"
        echo "${green}Trying to clone Scripts...${reset}"

        if [ "$(which git)" == "/usr/bin/git" ]; then
          mkdir -p /home/tim/projects/scripts
          git clone git@github.com:TimGoldbach/ubuntu-usage-analysis.git /home/tim/projects/scripts
          git clone git@github.com:TimGoldbach/ubuntu-wallpaper.git /home/tim/projects/scripts
        fi

        echo "${green}Scripts succesfully cloned!${reset}"

        ;;
      n)
        echo "${green}No Cronjobs installed!${reset}"

        ;;
    esac

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

  echo ""
  echo "${green}Installing Nginx...${reset}"
  echo ""
  sudo apt-get install nginx -y

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

  mkdir "projects"
  cd projects || exit

  mkdir "private"
  mkdir "school"
  mkdir "scripts"
  mkdir "shopware"

  cd school || exit
  git clone git@github.com:relativvv/Turbo_-_Das-Autoquiz.git
  git clone git@github.com:relativvv/GrammatickMietTiedemann.git
  cd ..

  cd scripts || exit
  git clone git@github.com:TimGoldbach/ubuntu-usage-analysis.git
  git clone git@github.com:TimGoldbach/ubuntu-wallpaper.git
  git clone git@github.com:TimGoldbach/ubuntu-check-if-harddrive-is-encrypted.git
  git clone git@github.com:TimGoldbach/ubuntu-setup.git
  cd ..

  cd shopware || exit
  mkdir cloud

  git clone git@github.com:TimGoldbach/tkitchenimplementation.git
  git clone git@github.com:shopware/6/product/platform.git
  git clone git@gitlab.shopware.com:product/handbook.git

  cd cloud || exit
  git clone git@github.com:shopware/6/product/platform.git

  cd platform/custom/plugins || exit
  git clone https://gitlab.shopware.com/shopware-cloud/rufus.git

  menuMessage
}

menuMessage

done
