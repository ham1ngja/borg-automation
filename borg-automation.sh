#!/bin/bash

echo -e "\n[$(date +"%T")] Local Borg Backup Initialising.\n"

echo "Backing up Brewfile..."

rm -f ~/.config/brew/Brewfile && brew bundle dump --file=~/.config/brew/Brewfile

echo -e "Brewfile has been backed up.\n"

paths=(
"/path"
"/more/paths"
)

BORG_PASSPHRASE=$(security find-generic-password -a borg -s BorgBackup -w) borg create --stats --progress ~/borg/borg.local::'local-{now:%Y-%m-%d-%H%M%S}' "${paths[@]}"

rsync -av --delete ~/borg/borg.local "/Volumes/borg" ; rsync -av --delete ~/borg/borg.local "/Volumes/borg.ssd"

echo -e "\n[$(date +"%T")] Local Borg Backup Complete. \n\n"
