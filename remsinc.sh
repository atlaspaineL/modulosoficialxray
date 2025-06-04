#!/bin/bash

delete_id() {
    if [ "$#" -ne 2 ]; then
        echo "Uso: $0 <uuid> <login>"
        exit 1
    fi

    uuidel="$1"
    login="$2"

    invaliduuid() {
        echo "UUID inválido"
        exit 1
    }

    config_file="/usr/local/etc/xray/config.json"
    alt_config_file="/etc/v2ray/config.json"

    if [ -f "$config_file" ]; then
        echo "Usando configuração em $config_file"
    elif [ -f "$alt_config_file" ]; then
        echo "Usando configuração em $alt_config_file"
        config_file="$alt_config_file"
    fi

    if grep -q "$uuidel" "$config_file"; then
        tmpfile=$(mktemp)
        jq --arg uuid "$uuidel" 'del(.inbounds[].settings.clients[] | select(.id == $uuid))' "$config_file" > "$tmpfile" && mv "$tmpfile" "$config_file" && chmod 777 "$config_file"

        echo "Objeto com 'id' igual a $uuidel removido"
        bash atlasremove.sh "$login"
    else
        invaliduuid
    fi
}

delete_id "$1" "$2"
