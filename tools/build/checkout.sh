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