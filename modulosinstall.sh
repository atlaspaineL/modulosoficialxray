#!/bin/bash
rm -f atlasdata.sh atlascreate.sh atlasteste.sh atlasremove.sh delete.py sincronizar.py add.sh rem.sh addteste.sh addsinc.sh remsinc.sh
wget -O atlascreate.sh "https://almirantessh.top/modulos/atlascreate.sh"
wget -O add.sh "https://almirantessh.top/modulos/add.sh"
wget -O remsinc.sh "https://almirantessh.top/modulos/remsinc.sh"
wget -O addsinc.sh "https://almirantessh.top/modulos/addsinc.sh"
wget -O rem.sh "https://almirantessh.top/modulos/rem.sh"
wget -O atlasteste.sh "https://almirantessh.top/modulos/atlasteste.sh"
wget -O addteste.sh "https://almirantessh.top/modulos/addteste.sh"
wget -O atlasremove.sh "https://almirantessh.top/modulos/atlasremove.sh"
wget -O delete.py "https://almirantessh.top/modulos/delete.py"
wget -O atlasdata.sh "https://almirantessh.top/modulos/atlasdata.sh"
wget -O sincronizar.py "https://almirantessh.top/modulos/sincronizar.py"
chmod 777 atlascreate.sh add.sh remsinc.sh addsinc.sh rem.sh atlasteste.sh addteste.sh atlasremove.sh delete.py atlasdata.sh sincronizar.py
sudo apt install dos2unix
dos2unix rem.sh
wget "https://almirantessh.top/modulos/verificador.py" -O verificador.py 
sudo python3 verificador.py
