#! /bin/bash

PID=$$
menus(){
	echo " "
	echo "1. Ver paquetes que están por actualizar."
	echo "2. Ver paquetes instalados."
	echo "3. Actualizar un paquete o varios paquetes."
	echo "4. Desinstalar un paquete."
	echo "5. Actualizar todo."
	echo "6. Instalar paquete."
	echo "7. Finalizar el script."
}

opciones(){
	local opcion
	echo " "
	read -p "Seleccionar una opción [ 1 - 7 ] " opcion
	echo " "
	case $opcion in
	1) nohup sudo apt update &> /dev/null;
	sudo apt list --upgradable | cut -d "/" -f 1 && sleep 2;;

	2) sudo dpkg --get-selections > paquetesinstalados.txt;
	cat paquetesinstalados.txt;
	echo " "
	echo -e "Estos son los paquetes que tienes instalados en el sistema."
	sleep 2
	rm -r paquetesinstalados.txt;;
	
	3) read -p "¿Cuantos paquetes vas a actualizar? " numero;
	if [ $numero -eq 1 ]
		then
			read -p "¿Que paquete quieres actualizar? " var1
			sudo apt install --only-upgrade $var1 2> paquete_error.txt
			actualizar=`cat paquete_error.txt | cut -d " " -f 1`
			if [[ $actualizar = "E:" ]]
				then
					echo " "
					echo -e "\e[0;31mEl paquete no existe.\e[0m\n"
					sleep 2
			else
				echo " "
				echo -e "\e[1;34mPaquete $var1 actualizado.\e[0m\n"
				sleep 2
			fi
	else
		for i in $(seq 1 $numero)
			do
				read -p "Dame el nombre del paquete $i: " var2
				sudo apt install --only-upgrade $var2 2> paquete_error.txt
				actualizar2=`cat paquete_error.txt | cut -d " " -f 1`
				if [[ $actualizar2 = "E:" ]]
					then
						echo " "
						echo -e "\e[0;31mEl paquete no existe.\e[0m\n"
						sleep 2
				else
					echo " "
					echo -e "\e[1;34mPaquete $var2 actualizado correctamente.\e[0m\n"
					sleep 2
				fi
			done
	fi;
	rm -r paquete_error.txt;;

	4) read -p "¿Cuantos paquetes quieres desinstalar?: " numero2;
	echo " "
	read -p "¿Quieres ver la lista de paquetes que tienes instalado? (Si/No) " var6
	if [ $var6 = "Si" ]
		then
			sudo dpkg --get-selections > paquetesinstalados.txt
			cat paquetesinstalados.txt
			echo " "
	else
		echo " "
	fi;
	if [ $numero2 -eq 1 ]
		then
			read -p "¿Que paquete quieres desinstalar? " var3
			sudo apt remove --purge $var3 > paquete_error.txt
			desisntalador3=`cat paquete_error.txt | head -4 | tail -1`
			if [[ $desisntalador3 = "El paquete «$var3» no está instalado, no se eliminará" ]]
				then
					echo " "
					echo -e "\e[0;31mEl paquete no existe.\e[0m\n"
					sleep 2
			else
				echo " "
				echo -e "\e[1;34mPaquete $var3 desisntalado correctamente.\e[0m\n"
				sleep 2
			fi
	else
		for i in $(seq 1 $numero2)
			do
				read -p "Dame el nombre del paquete $i: " var4
				sudo apt remove --purge $var4 > paquete_error.txt
				desisntalador=`cat paquete_error.txt | head -4 | tail -1`
				if [[ $desisntalador = "El paquete «$var3» no está instalado, no se eliminará" ]]
					then
						echo " "
						echo -e "\e[0;31mEl paquete no existe.\e[0m\n"
						sleep 2
				else
					echo " "
					echo -e "\e[1;34mPaquete $var4 desisntalado correctamente.\e[0m\n"
					sleep 2
				fi
				sleep 1
			done
		echo -e "Se han eliminado los paquetes.\n"
	fi;
	rm -r paquete_error.txt;;

	5) read -p "¿Estas seguro que quieres actualizar todos los paquetes? (Si/No) " var5;
	if [ $var5 = "Si" ]
		then
			sudo apt update
			sudo apt upgrade 
	else
		echo " "
		echo -e "No se a actualizado ningún paquete.\n"
		sleep 2
	fi;;

	6) read -p "¿Que paquetes quieres instalar? " instalador;
	sudo apt install $instalador 2> paquete_error.txt;
	instalador1=`cat paquete_error.txt | cut -d " " -f 1`;
	if [[ $instalador1 = "E:" ]]
		then
			echo " "
			echo -e "\e[0;31mEl paquete no existe.\e[0m\n"
			sleep 2
	else
		echo " "
		echo -e "\e[1;34mPaquete $instalador instalado correctamente.\e[0m\n"
		sleep 2
	fi;
	rm -r paquete_error.txt;;
	
	7) echo "Fin." && sleep 1;
	kill -9 $PID;;
	

	*) echo -e "\e[0;31mError...\e[0m" && sleep 2
	esac
}