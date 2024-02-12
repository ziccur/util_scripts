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


#! Main
echo "Indica la ruta absoluta de la carpeta "introprg":\nEjemplo: /home/ziccur/Documents/introprg"
read path

echo "Indica la sección que quieres (31,33) o (3 para todos): "
read section

#! Check if the directory exists
if ls "$path" >/dev/null 2>&1; then
    
    #! Delete output files if they exist
    rm /tmp/output.prgtest 2>/dev/null
    rm /tmp/error.prgtest 2>/dev/null
    rm /tmp/resultPrgtestSearch 2>/dev/null

    find $path/$section* -type d >> /tmp/resultPrgtestSearch

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





