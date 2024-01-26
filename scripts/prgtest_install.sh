##############################################################################################################################
#                                                                                                                           #
# Este programa esta destinado a instalar un software de uso educativo llamado "prgtest" en un ordenador con GNU/Linux      #
# Propietario del software en cuestión: gatrenat (https://github.com/gatrenat)
#                                                                                                                           #
#############################################################################################################################

#### CONFIGURAR ENTORNO ####

sudo apt-get install -y git > /dev/null

#### CONFIGURACIÓN PERSONALIZADA DE GIT ####
echo "Introduce tu nombre: "
read name

echo "Introduce tu correo: "
read email

git config --global user.name "$name"
git config --global user.email "$email"





