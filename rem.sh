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

    if grep -q "$uuidel" /usr/local/etc/xray/config.json; then
        tmpfile=$(mktemp)
        jq --arg uuid "$uuidel" 'del(.inbounds[].settings.clients[] | select(.id == $uuid))' /usr/local/etc/xray/config.json > "$tmpfile" && mv "$tmpfile" /usr/local/etc/xray/config.json && chmod 777 /usr/local/etc/xray/config.json

        sudo systemctl restart xray
        echo "Objeto com 'id' igual a $uuidel removido"
        bash atlasremove.sh "$login"
    else
        invaliduuid
    fi
}

delete_id "$1" "$2"
