#!/bin/bash
# input="./addons.txt"
# mkdir -p addons
# while IFS= read -r line
# do
#    repo=$(echo  "$line"| awk '{print $1;}')
#    dir=$(echo "$repo"| awk -F'/' '{print $NF}')
#    cd addons
#    git clone "$repo" && cd "$dir"
#    commit=$(echo  "$line"| awk '{print $2;}')
#    git checkout "$commit"
#    cd ..
# done < "$input"
cd addons
echo $(find . -maxdepth 2 -type d ! -name '.*' -printf '%f,') 