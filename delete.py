#!/usr/bin/python
# -*- coding: utf-8 -*-
# atlasremove.py
import os
import sys
import time

if len(sys.argv) != 2:
    sys.exit(1)

nome_arquivo = sys.argv[1]

with open(nome_arquivo, 'r') as arquivo:
    linhas = arquivo.readlines()
    linhas = [linha for linha in linhas if linha.strip()]

    for linha in linhas:
        colunas = linha.split()
        if len(colunas) >= 2:
            os.system("./remsinc.sh " + colunas[1] + " " + colunas[0])
        else:
            linha = linha.replace(' ', '')
            os.system("./atlasremove.sh " + linha)
    arquivo.close()
    os.system("rm " + nome_arquivo)
    # Verificar qual arquivo de configuração existe e usar o apropriado
    config_file="/usr/local/etc/xray/config.json"
    config_file_alt="/etc/v2ray/config.json"

    if os.path.exists("$config_file"):
        os.system("sudo systemctl restart xray")
    elif os.path.exists("$config_file_alt"):
        os.system("sudo systemctl restart v2ray")
