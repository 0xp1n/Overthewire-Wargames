#!/usr/bin/env bash

CURRENT_DIR=$(pwd)

source "$CURRENT_DIR/utils/helpers.sh"

# ANSII ESCAPE CODE COLOURS
greenColour='\033[0;32m'
redColour='\033[0;31m'
blueColour='\033[0;34m'
yellowColour='\033[1;33m'
purpleColour='\033[0;35m'
cyanColour='\033[0;36m'
grayColour='\033[0;37m'

endColour='\033[0m'

# Auto detect the package manager for the target OS
package_manager=$(whichPackageManager)
target_home_config_dir="$HOME/.config"

echo -e "${yellowColour}The package manager for the entire installation will be${endColour} ${cyanColour}$package_manager${endColour}"

function setupHotkeys() {
    #  REMEMBER TO UNCOMMENT THIS ON THE LINUX TARGET SYSTEM
    #$package_manager sxhkdrc
    backupTargetConfigurationFolder

    echo -e "${grayColour}Copying sxhkd configuration files in order to setup hotkeys...${endColour}"
    cp -r "$CURRENT_DIR/config/sxhkd" "$target_home_config_dir"
    echo -e "${greenColour} Hotkeys installed and configured with${endColour} ${cyanColour}[ sxhkd ]${endColour}"
}

function setupCustomTerminalFont() {
    echo -e "${grayColour}Downloading HackNerdFont from${endColour} ${blueColour}https://github.com/ryanoasis/nerd-fonts/${endColour}"
   
    local fonts_dir="$HOME/.fonts"
    mkdir -p "$fonts_dir"
    curl -sLo Hack.zip https://github.com/ryanoasis/nerd-fonts/releases/download/v2.3.3/Hack.zip && unzip -q Hack.zip -d "$fonts_dir" && rm Hack.zip

    echo -e "${greenColour} Fonts installed and configured in${endColour} ${cyanColour}[ $fonts_dir ]${endColour}"

}

function backupTargetConfigurationFolder() {
    if [ -d "$target_home_config_dir" ]; then
        local -r config_backup_folder=$target_home_config_dir/backup/${USER}.config

        echo -e "${greenColour}Detected existing .config folder${endColour}, ${yellowColour}creating backup on${endColour} ${cyanColour}$config_backup_folder"
        
        mkdir -p "$config_backup_folder" && cp -r "$target_home_config_dir" "$config_backup_folder"
    fi
}
###
# START THE INSTALLATION AND CONFIGURATION PROCESS FOR THE NEW ENVIRONMENT
###
setupHotkeys
setupCustomTerminalFont