#!/bin/bash

# Comprobación del parametro del proceso
if [ $# -eq 0 ]; then
    echo "Use: $0 <process name>"
    exit 1
fi


while true; do
    
    # Guarda el nombre del proceso
    proceso=$1
    # Guarda en un fichero solo la primera linea del resultado de la busqueda de procesos
    ps -A | grep "$proceso" | head -n 1 > /tmp/kill-proces-tmp

    # Comprueba si el fichero en /tmp esta vacio (si esta vacio finaliza)
    if [ -s "/tmp/kill-proces-tmp" ]; then
        ID=$(cat /tmp/kill-proces-tmp | awk '{print $1}') #Sobrescribe el fichero solo con el numero de proceso
        kill "$ID"
        rm /tmp/kill-proces-tmp #borrar fichero
        sleep 0.2
    else
        break
    fi
done

echo "Killed $proceso"



