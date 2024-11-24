#!/data/data/com.termux/files/usr/bin/bash

blue:  ("\033[94m 
█▀▄ ▀ █▄░█     ▄▀▀░ █▀▀ █▄░█ 
█▀█ █ █░▀█     █░▀▌ █▀▀ █░▀█ 
▀▀░ ▀ ▀░░▀     ▀▀▀░ ▀▀▀ ▀░░▀ 
 \033[0m")+
# Función para generar una contraseña segura
generate_password() {
    local LENGTH=$1
    password=$(date +%s | sha256sum | base64 | head -c $LENGTH)
    echo $password
}

# Función para generar un nombre latino
generate_latin_name() {
    local NAMES=("Luis" "Maria" "Alejandro" "Sofia" "Carlos" "Ana")
    local name=${NAMES[$RANDOM % ${#NAMES[@]} ]}
    echo $name
}

# Pedir al usuario la cantidad de contraseñas a generar
read -p "Cuantas contraseñas quieres generar? " num_passwords

# Crear directorio en la tarjeta SD si no existe
output_dir="/sdcard/contraseñas/"
mkdir -p $output_dir

# Generar contraseñas y guardar en archivos
for ((i=1; i<=$num_passwords; i++)); do
    password=$(generate_password 16)
    name=$(generate_latin_name)
    echo "Contraseña $i: $name$password"
    echo "$name$password" >> "${output_dir}contraseña_$i.txt"
done

echo "Todas las contraseñas han sido generadas y guardadas en $output_dir"