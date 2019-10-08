#!/bin/bash
git config --global user.name 'Luis'
git config --global user.email 'luis.garcia@savoirfairelinux.com'
input="./addons.txt"
while IFS= read -r line
do
   repo=$(echo  "$line"| awk '{print $1;}')
   dir=$(echo "$repo"| awk -F'/' '{print $NF}')
   cd git
   git clone "$repo" && cd "$dir"
   commit=$(echo  "$line"| awk '{print $2;}')
   git checkout "$commit"
   cd ..
done < "$input"
cd git
echo $(find . -maxdepth 2 -type d ! -name '.*' -printf '%f,') 

addons=$(find . -maxdepth 1 -type d ! -name '.*' -printf '%f,') 
addons_path="addons_path = /opt/odoo/git/odoo/odoo/addons/,/opt/odoo/git/odoo/addons/"
home="/opt/odoo/git/"

for i in $(echo "$addons" | sed "s/,/ /g")
do
    if [ "$i" == "odoo" ]; then
    continue
    fi
    # call your procedure/other scripts here below
    addons_path="${addons_path},${home}$i/"
done
# TODO: check if addons attribute is present
echo "$addons_path" >> ../odoo.conf
