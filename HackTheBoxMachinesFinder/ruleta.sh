#!/usr/bin/env bash

greenColour='\033[0;32m'
redColour='\033[0;31m'
blueColour='\033[0;34m'
yellowColour='\033[1;33m'
purpleColour='\033[0;35m'
cyanColour='\033[0;36m'
grayColour='\033[0;37m'

endColour='\033[0m'

function showHelpPanel() {
    echo -e "\n${yellowColour}[+]${endColour}${grayColour} Uso:${endColour}"
    echo -e "\n\t${purpleColour}-m${endColour}${grayColour} Asignar dinero inicial para las apuestas${endColour}"
    echo -e "\n\t${purpleColour}-t${endColour}${grayColour} Seleccionar técnica de apuesta (martingala, reverseLaboucher)${endColour}"
    echo -e "\n\t${purpleColour}-h${endColour}${grayColour} Mostrar ayuda${endColour}\n"
}

declare -i money=0
declare -a techniques=("martingala" "reverseLaboucher")

function martingala() {
    bet=0
    even_or_odd=''

    while [ "$bet" -eq 0 ]; do
        read -rp "¿De cuánto será la apuesta inicial? --> " bet

        if [ "$bet" -le 0 ]; then
            echo -e "${redColour}Apuestas negativas no están permitidas${endColour}"
        fi
    done

    while [ "$even_or_odd" != "p" ] && [ "$even_or_odd" != "i" ] ; do
        read -rp "¿Apuestas al impar o par? [i]mpar [p]ar --> " even_or_odd
    done


    while true; do 
        number=$((RANDOM % 37))
        echo -e "${yellowColour}Ha sálido el número${endColour} ${greenColour}$number ${endColour}"
    done
}

function reverseLaboucher() {
    echo "reverse laboucher EN TU CARA"
}


function setMoney() {
    money=$1
    if [ $money -gt 0 ]; then
        echo -e "${cyanColour}Su saldo de entrada es de:${endColour} ${yellowColour}$money €${endColour}"
    else
        echo -e "${redColour}Seleccione una cantidad mayor que${endColour} ${yellowColour}0€${endColour} ${redColour}como saldo ${endColour}"
        exit 1
    fi
}

function chooseTechnique() {
    selectedOption=$1
    technique='unknown'

    for option in "${techniques[@]}"; do
        if [ "$option" = "$selectedOption" ]; then
                technique=$option
                echo -e "${cyanColour}Va a utilizar la técnica${endColour} ${yellowColour}$technique${endColour} ${cyanColour}para las siguientes jugadas${endColour}"
                break   
        fi
    done
  
  if [ "$technique" = "unknown" ]; then 
    echo -e "${redColour}Por favor seleccione una técnica valida:${endColour} ${yellowColour}[+] martingala [+] reverseLaboucher${endColour}"
    exit 1
 fi

 # Calling the valid function for the selected technique
 $technique
}


while getopts ":m:t:h:" arg; do
    case $arg in
        m)
        setMoney "$OPTARG"
        ;;
        t)
        chooseTechnique "$OPTARG"
        ;;
        h | *)
            showHelpPanel
        ;;
    esac
done
