#!/usr/bin/env bash

# Colours https://en.wikipedia.org/wiki/ANSI_escape_code
# Black        0;30     Dark Gray     1;30
# Red          0;31     Light Red     1;31
# Green        0;32     Light Green   1;32
# Brown/Orange 0;33     Yellow        1;33
# Blue         0;34     Light Blue    1;34
# Purple       0;35     Light Purple  1;35
# Cyan         0;36     Light Cyan    1;36
# Light Gray   0;37     White         1;37

greenColour='\033[0;32m'
redColour='\033[0;31m'
blueColour='\033[0;34m'
yellowColour='\033[1;33m'
purpleColour='\033[0;35m'
cyanColour='\033[0;36m'
grayColour='\033[0;37m'

endColour='\033[0m'

# Source of information
source="https://htbmachines.github.io"

function showHelpPanel() {
    echo -e "\n${yellowColour}[+]${endColour}${grayColour} Uso:${endColour}"
    echo -e "\n\t${purpleColour}-m${endColour}${grayColour} Buscar por nombre de máquina${endColour}"
    echo -e "\n\t${purpleColour}-u${endColour}${grayColour} Descargar o actualizar archivos necesarios${endColour}"
    echo -e "\n\t${purpleColour}-h${endColour}${grayColour} Mostrar ayuda${endColour}\n"
}

function searchMachine() {
    machine=$1
    echo -e "Looking for $machine..."
}

function updateHTBMachines() {
    hideCursor
    SECONDS=0

     if [ -f "htbmachines.bundle.js" ]; then
        echo -e "${yellowColour}Se ha detectado un archivo htbmachines.bundle.js, actualizando...${endColour}"
    fi
   
    echo -e "${greenColour}Descargando y actualizando datos de máquinas...${endColour}"
    curl -sX GET $source/bundle.js | js-beautify > htbmachines.bundle.js
    duration=$SECONDS

    echo -e "\n${greenColour}Finalizado con éxito en $((duration / 60)) minutes and $((duration % 60)) seconds${endColour}"

    showCursor
}

function hideCursor() {
    tput civis
}

function showCursor() {
    tput cnorm
}
# The basic syntax of getopts is (see: man bash):

# getopts OPTSTRING VARNAME [ARGS...]

# where:

#     OPTSTRING is string with list of expected arguments,
#         h - check for option -h without parameters; gives error on unsupported options;
#         h: - check for option -h with parameter; gives errors on unsupported options;
#         abc - check for options -a, -b, -c; gives errors on unsupported options;

#         :abc - check for options -a, -b, -c; silences errors on unsupported options;

#         Notes: In other words, colon in front of options allows you handle the errors in your code. Variable will contain ? in the case of unsupported option, : in the case of missing value.

#     OPTARG - is set to current argument value,
#     OPTERR - indicates if Bash should display error messages.


while getopts ":m:uh:" arg; do
    case $arg in
        m)
            machine=$OPTARG;
            searchMachine "$machine"
        ;;
        u)
            updateHTBMachines
        ;;
        h | *)
            showHelpPanel
        ;;
    esac

done