#! /bin/bash

echo "Bienvenido al programa de instalador y desinstalador de paquetes."

echo "--------------------------------------------------"

echo -e "Selecciona la opción que quieras ejecutar.\n"

echo -e "\e[0;31mADVERTENCIA: Necesitas tener \"sudo\" instalado para ejecutar el script.\e[0m"

. ./script24.sh

while true
do
	menus
	opciones
done