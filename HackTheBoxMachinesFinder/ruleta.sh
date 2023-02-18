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

declare -i games_played=0
declare -i total_wins=0
declare -i total_loses=0

function martingala() {
    bet=0
    even_or_odd=''

    while [ $((money - bet)) -le 0 ] || [ "$bet" -le 0 ]; do
        read -rp "¿De cuánto será la apuesta inicial? --> " bet

        if [ "$bet" -le 0 ]; then
            echo -e "${redColour}Apuestas negativas no están permitidas${endColour}"
        fi

        if [ $((money - bet)) -le 0 ]; then
            echo -e "${redColour}La apuesta de${endColour}${yellowColour} $bet €${endColour} ${redColour}es mayor que el saldo disponible${endColour} ${yellowColour}$money €${endColour}"
        fi
    done

    while [ "$even_or_odd" != "p" ] && [ "$even_or_odd" != "i" ] ; do
        read -rp "¿Apuestas continuamente al impar o par? [i]mpar [p]ar --> " even_or_odd
    done

    echo -ne "${yellowColour} Vas a utilizar una apuesta inicial de $bet € al $even_or_odd"

    while [ "$money" -gt 0 ]; do 
        ((money-="$bet"))

        if [ $money -le 0 ]; then
            echo -e "${redColour}Lo sentimos ya no puedes seguir apostando con la técnica martingala, tu dinero restante es de $((money+=bet)) €${endColour}"
            break;
        fi

        ((games_played+=1))
        echo -e "\nTienes $money € y tu apuesta actual es de $bet €"

        number=$((RANDOM % 37))
        result='impar'

        echo -e "${yellowColour}Ha salido el número $result ${endColour} ${greenColour}$number${endColour}"

        if [ $((number % 2)) -eq  0 ]; then
            result='par'
        fi

        if [ "$even_or_odd" = ${result:0:1} ]; then
             ((money+=bet * 2))
             echo -e "${greenColour}Has ganado esta ronda, se te ha reembolsado${endColour} ${yellowColour}$((bet * 2)) €${endColour}"
            ((total_wins+=1))

        else 
            ((bet*=2))
            echo -e "${redColour}Has perdido esta ronda, duplicando la apuesta a${endColour}${redColour} $bet €${endColour}"
            ((total_loses+=1))
        fi

    done

    echo -e "Has jugado un total de $games_played veces\n"
    echo -e "De los cuales has ganado $total_wins veces\n"
    echo -e "Y has perdido $total_loses veces\n"
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
