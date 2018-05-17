#! /bin/bash

echo -e "Bienvenido al programa de instalador y desinstalador de paquetes.\n"

echo "Con este scrip podras automatiza la actualización del sistema indicando qué paquetes se desean actualizar y cuales desinstalar, creando una interacción con el usuario."

echo "--------------------------------------------------"

echo -e "Selecciona la opción que quieras ejecutar.\n"

echo -e "\e[0;31mADVERTENCIA: Necesitas tener \"sudo\" instalado para ejecutar el script.\e[0m"

. ./script24.sh

while true
do
	menus
	opciones
done