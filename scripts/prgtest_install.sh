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

#### CREATE SSH KEY & ADD TO GITHUB ####

Key="~/.ssh/githubKey_byZiccur"

if [ -e "$Key" ]; then
    echo "Parece que ya tienes una clave con el mismo nombre, el programa usará esa"
else
    ssh-keygen -t ed25519 -f ~/.ssh/githubKey_byZiccur -N "" > /dev/null 2>&1
    echo "Clave creada en el directorio '$HOME/.ssh/', recuerda no compartirla con nadie"
fi
sleep 4

firefox "https://hackmd.io/@Yeray2/ssh-github" > /dev/null 2>&1 &
clear

for i in {10..1}
do
   echo "Tiempo para mostrar la clave: $i"
   sleep 1
done


## CREATE A TXT WITH PUB KEY AND PRINT IT ON GEDIT ##
cat ~/.ssh/githubKey_byZiccur.pub > /tmp/ziccur.key
echo "CIERRA ESTA VENTANA DESPUES DE AÑADIR LA CLAVE" >> /tmp/ziccur.key
gedit /tmp/ziccur.key


#### CLONE REPOSITORY CHECK AND CLONE ####
clear
folder="$HOME/introprg"
if [[ -d "$folder" ]]; then
    echo "##### \e[32mYa tenias el repositorio clonado en $HOME,\e[0m sino lo tienes puede haber un problema con el script (Ponte en contacto con los colaboradores) #####"
    sleep 5
    clear
else
    
    echo -e "#### Repositorio Local no encontrado. Clonando repositorio de: \e[34mgit@github.com:$ghUser/introprg.git\e[0m "
    export GIT_SSH_COMMAND="ssh -o StrictHostKeyChecking=no"
    git clone git@github.com:$ghUser/introprg.git $HOME/introprg
fi

bash ~/introprg/.introprg/configura_introprg.sh
bash ~/introprg/.introprg/install_junit.sh
sleep 1
source ~/.bashrc