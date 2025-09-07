#!/bin/bash

backup_dir="$HOME/code/dotbackup/"
backup_list_loc="$HOME/.dot.list"

add_to_backup_list() {
    if [ ! -f $1 ]; then
        echo "MUST BE A FILE"
        return
    fi

    if [ ! -f "$backup_list_loc" ]; then
        touch "$backup_list_loc"
        echo "MADE BACKUP LIST AT $backup_dir "
    fi

    if grep -q "$1" "$backup_list_loc"; then
        echo "FILE $1 ALREADY IN LIST"
        return
    fi

    echo $1 >> $backup_list_loc
    echo "ADDED $1 TO BACKUP LIST - $backup_list_loc"
}

remove_from_backup_list() {
    if [ ! -f $1 ]; then
        echo "MUST BE A FILE "
        return
    fi

    if [ ! -f "$backup_list_loc" ]; then
        echo "NO BACKUP LIST "
        return
    fi

    if ! grep -q "$1" "$backup_list_loc"; then
        echo "NO SUCH FILE - $1 "
    fi

    content=$(<$backup_list_loc)
    content=$(echo "$content" | grep -v "$1")

    echo $content > $backup_list_loc
    echo "REMOVED $1 FROM LIST"
}

backup_from_list() {
    if [ ! -f "$backup_list_loc" ]; then
        echo "NO BACKUP LIST "
        return
    fi

    while IFS= read -r file_name; do
    echo "copying $file_name to $backup_dir"
    cp "$file_name" "$backup_dir"
    done < $backup_list_loc

    echo "BACKUP TO $backup_dir"
}

"$@"
