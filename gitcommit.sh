#! /bin/bash

# This script removes all symbolic links and copies the source files
# to the destination. After adding the files to git the changes made are
# reversed

ls -alR | grep ":$" | grep -o "[^:]*" |
    while read dir; do
        if [[ $dir != "." || $dir != ".." || $dir != " " ]]; then
            ls -al $dir |
                while read file; do
                    linkFile="$(echo $file | grep "^l" | awk '{print $9}')"
                    if [[ $linkFile != "" ]]; then
                        dest="$(echo $file | grep "^l" | awk '{print $11}')"
                        echo "$dir/$linkFile -> $dest" >>temp
                        rm -r "$dir/$linkFile"
                        cp -r $dest "$dir/$linkFile"
                    fi
                done
        fi
    done

git add .

cat temp |
    while read line; do
        source="$(echo $line | awk '{print $3}')"
        dest=$(echo $line | awk '{print $1}')
        rm -r $dest
        ln -s $source $dest
    done

rm temp
