#?#############################################################
#? This script is used to run the prgtest for all the folders #
#? Prgtest is a software for educational purposes, created by #
#?           gatrenat (https://github.com/gatrenat)           #
#?                                                            #
#?    This script use Better Comments plugins for VSCode      #
#?#############################################################

#! Color defines
    green='\033[0;32m'
    reset='\033[0m'
    red='\033[0;31m'
    blue='\033[0;36m'
    red_bold='\033[1;31m'

#! Declare functions
    #? Function to specific folder and run prgtest
    runPrgtest(){
        
        #! Sleep to avoid errors in some computers
        #sleep 0.5
        cd $1
        javac *.java > /dev/null 2>&1
        prgtest >> /tmp/output.prgtest 2>> /tmp/error.prgtest
        if [ "$?" -eq 0 ]; then
            return 0  
        else
            return 1  #! if the last command wasn't successful
        fi
    }

    #? Function to print banner of the script
    printBanner(){
        clear
        echo -e "${blue}###############################################################################${reset}" 
        echo -e "${blue}                 _            _           _ _ _____     _     _               ${reset}"
        echo -e "${blue} _ __  _ __ __ _| |_ ___  ___| |_    __ _| | |  ___|__ | | __| | ___ _ __ ___ ${reset}"
        echo -e "${blue}| '_ \| '__/ _' | __/ _ \/ __| __|  / _' | | | |_ / _ \| |/ _' |/ _ \ '__/ __|${reset}"
        echo -e "${blue}| |_) | | | (_| | ||  __/\__ \ |_  | (_| | | |  _| (_) | | (_| |  __/ |  \__ \\ ${reset}"
        echo -e "${blue}| .__/|_|  \__, |\__\___||___/\__|  \__,_|_|_|_|  \___/|_|\__,_|\___|_|  |___/${reset}"
        echo -e "${blue}|_|        |___/                                                              ${reset}"
        echo -e "${blue}############################ By: zciccur & Snr1s3 ############################${reset}"  
    }

    #? Function to check if is a valid folder
    checkFolder(){
        if [ -d "$1" ]; then
            return 0
        else
            return 1
        fi
    }


#! Main

#! Print banner
printBanner

echo ""
echo "Indica la ruta absoluta de la carpeta "introprg":"
echo -e "${green}Ejemplo: /home/ziccur/Documents/introprg${reset}"
echo ""
read path

if ! checkFolder $path; then
    echo -e "${red_bold}La carpeta no existe, prueba a ejecutar el script de nuevo.${reset}"
    exit 1
fi

echo "Indica la sección que quieres (31,33) o (3 para todos): "
read section

#! Check if the directory exists
if ls "$path" >/dev/null 2>&1; then
    
    #! Delete output files if they exist
    rm /tmp/output.prgtest 2>/dev/null
    rm /tmp/error.prgtest 2>/dev/null
    rm /tmp/resultPrgtestSearch 2>/dev/null

    find $path/$section* -type d >> /tmp/resultPrgtestSearch 2>/dev/null

    if [ "$?" -ne 0 ]; then
        echo -e "${red_bold}No se encontraron carpetas que concidan con:${reset} $section"
        exit 1
    fi

    #! Call prgtest for each folder
    if wc -l < /tmp/resultPrgtestSearch > 0; then
        while read -r line; do
            #! Call function to specific folder and run prgtest
            runPrgtest $line 

            #! Get the name of the folder and modify it to show only the section
            name=$(basename $line)
            name=${name:0:5}

            #! Check if the last command was successful if wasn't break the loop
            if [ "$?" -eq 0 ]; then
                echo -e "$name ${green}PASSA${reset}"
            else
                echo -e $name "${red}NO PASSA${reset}"
                break

            fi
        done < /tmp/resultPrgtestSearch

    else
        echo "No se encontraron carpetas con el nombre $section*"
    fi
    

#! Case: insuficient permissions
else
    echo "El script no tiene permisos para ver el contenido de $path"
fi





