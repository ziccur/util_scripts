##############################################################################################################################
#                                                                                                                           #
# Este programa esta destinado a instalar un software de uso educativo llamado "prgtest" en un ordenador con GNU/Linux      #
# Propietario del software en cuestión: gatrenat (https://github.com/gatrenat)
#                                                                                                                           #
#############################################################################################################################

#!/bin/bash

#### TEST ZONE ####

#### CONFIGURAR ENTORNO ####

echo "A continuación pedirá la contraseña de usuario para instalar (Java & Git)"
sudo apt-get install -y git > /dev/null
sudo apt-get install -y default-jdk > /dev/null

clear
echo "Git instalado correctamente"
echo "Java (default-jdk) instalado correctamente"

#### CONFIGURACIÓN PERSONALIZADA DE GIT ####
echo "Introduce tu nombre: "
read name

echo "Introduce tu correo: "
read email

git config --global user.name "$name"
git config --global user.email "$email"

echo "Nombre de usuario de Github"
read ghUser

#### REFUSED PART FOR USER COMODITY ####
# firefox "https://32e23a8f-d5c1-46ef-bad7-31aa74cfb616-00-3dmsolo0u19xz.kirk.replit.dev/" &
# echo "Link SSH copiado: "
# read repository # Problems with name: user, github, link

#### CLONE REPOSITORY ####
clear
echo "##### Clonando repositorio en el Escritorio de $USER"



cd ~
GIT_SSH_COMMAND="ssh -o StrictHostKeyChecking=no" git clone git@github.com:$ghUser/introprg.git
clear

echo "##### Repositorio clonado en /home/$USER/introprg #####"






