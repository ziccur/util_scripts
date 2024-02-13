#?############################################################################################################################
#?                                This script is used to run the prgtest for all the folders                                 #
#?              Prgtest is a software for educational purposes, created by gatrenat (https://github.com/gatrenat)            #
#?                                                                                                                           #
#?                                    This script use Better Comments extension for VSCode                                   #
#?############################################################################################################################
#* By zciccur & Snr1s3 - 13/02/2024

#! Color defines
    green='\033[0;32m'
    reset='\033[0m'
    red='\033[0;31m'
    blue='\033[0;36m'
    red_bold='\033[1;31m'

#! Declare functions
    #? Function to specific folder and run prgtest
    runPrgtest(){
        
        cd $1

        rm /tmp/output.prgtest 2>/dev/null
        
        javac *.java > /dev/null 2>&1
        prgtest >> /tmp/output.prgtest

        #! Check line by line if the output of prgtest contains the word "FALLA"
        while read -r outputLine; do
            if [[ $outputLine == *"FALLA"* ]] || [[ $outputLine == *"ERROR"* ]]; then
                return 1
                break
            else 
                return 0
            fi
        done < /tmp/output.prgtest
        
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



#* Main
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
    rm /tmp/resultPrgtestSearch 2>/dev/null

    find $path/$section* -type d >> /tmp/resultPrgtestSearch 2>/dev/null

    if [ "$?" -ne 0 ]; then
        echo -e "${red_bold}No se encontraron carpetas que concidan con:${reset} $section"
        exit 1
    fi

    #! Call prgtest for each folder
    if wc -l < /tmp/resultPrgtestSearch > 0; then
        while read -r line; do
            

            #! Get the name of the folder and modify it to show only the section
            name=$(basename $line)
            name=${name:0:5}
            error="false"
            #! Call function to specific folder and run prgtest
            runPrgtest $line 
            #! Check if the last command was successful if wasn't break the loop

            if grep -q "ERROR" /tmp/output.prgtest; then
                echo -e $name "${red}NO PASSA${reset}"
                cat /tmp/output.prgtest
                error="true"
            else
                echo -e "$name ${green}PASSA${reset}"
            fi
            
            
            if [ "$error" == "true" ]; then
                echo -e "${red_bold}Se ha encontrado un error en $(basename $line) quieres continuar (S/N) ${reset}"
                read response

                while [ true ]; do
                    if [ "$response" == "S" ] || [ "$response" == "s" ]; then
                        break
                    elif [ "$response" == "N" ] || [ "$response" == "n" ]; then
                        exit 1
                    else
                        echo -e "${red_bold}Por favor, introduce una respuesta válida (S/N)${reset}"
                        read response
                    fi
                done
            fi

            

            

        done < /tmp/resultPrgtestSearch


    else
        echo "No se encontraron carpetas con el nombre $section*"
    fi
    

#! Case: insuficient permissions
else
    echo "El script no tiene permisos para ver el contenido de $path"
fi





