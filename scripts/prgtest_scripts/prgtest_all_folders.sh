#*#############################################################
#* This script is used to run the prgtest for all the folders #
#* Prgtest is a software for educational purposes, created by #
#*           gatrenat (https://github.com/gatrenat)           #
#*                                                            #
#*    This script use Better Comments plugins for VSCode      #
#*#############################################################

echo "Indica la ruta absoluta de la carpeta "introprg":\nEjemplo: /home/ziccur/Documents/introprg\n"
read path

echo "Indica la sección que quieres (31,33) o (3 para todos): "
read section

#! Check if the directory exists
if ls "$path" >/dev/null 2>&1; then
    
    find $path/$section* -type d >> /tmp/resultPrgtestSearch



#! Case: insuficient permissions
else
    echo "El script no tiene permisos para ver el contenido de $directory"
fi



