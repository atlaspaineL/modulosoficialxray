#!/bin/bash

# Verificar se o número correto de argumentos foi fornecido
if [ "$#" -ne 5 ]; then
    echo "Uso: $0 <novo_id> <email> <senha> <validade> <limite>"
    exit 1
fi

# Atribuir argumentos a variáveis
uuid="$1"
email="$2"
senha="$3"
validade="$4"
limite="$5"
config_file="/usr/local/etc/xray/config.json"
alt_config_file="/etc/v2ray/config.json"

if [ -f "$config_file" ]; then
    echo "Usando configuração em $config_file"
elif [ -f "$alt_config_file" ]; then
    echo "Usando configuração em $alt_config_file"
    config_file="$alt_config_file"
fi

# Verificar se o novo ID já existe na configuração
if grep -q "\"id\": \"$uuid\"" "$config_file"; then
    echo "2"
else
    # Adicionar o novo cliente ao JSON
    new_client='{"id": "'$uuid'", "alterId": 0, "email": "'$email@gmail.com'"}'
    new_client2='{"email": "'$email@gmail.com'", "id": "'$uuid'", "level": 0}'
    jq --argjson newclient "$new_client" --argjson newclient2 "$new_client2" '(.inbounds[0].settings.clients += [$newclient]) | (.inbounds[1].settings.clients += [$newclient2])' "$config_file" > tmpfile && mv tmpfile "$config_file" && chmod 777 "$config_file"
    echo "1"

    if [ -f "/etc/v2ray/config.json" ]; then
        sudo systemctl restart v2ray
    else
        sudo systemctl restart xray
    fi

    bash atlasteste.sh $email $senha $validade $limite 
fi
