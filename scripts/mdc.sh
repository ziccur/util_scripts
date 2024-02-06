#############################################################################################################################
#                                                                                                                           #
# Este programa hace una funcion fácil per útil, por lo menos en mi caso. Te da la opción de crear una carpeta y acceder a  #
# ella directamente desde terminal, mezcla "mkdir" y "cd" consecutivamente. Este programa esta hecho con la intención  de   #
# hacer el uso por terminal mas cómodo y para ahorrar esos segundos escribiendo un comando extra.                           #
#                                                                                                                           #
# Uso del comando: bash mcd <nombre carpeta>                                                                                #
#                                                                                                                           #
#############################################################################################################################

#!/bin/bash

# Comprobación del parametro 
if [ $# -eq 0 ]; then
    echo "Use: $0 <folder name>"
    exit 1
fi

# Nombre de la carpeta
nombreCarpeta=$1

mkdir "$nombreCarpeta"
cd "$nombreCarpeta"
