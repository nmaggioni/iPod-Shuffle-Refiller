#!/bin/bash
if [ -z "$1" ]; then
    echo "Please pass the full path to the iPod folder (without trailing slash) as the first parameter."
    exit 1
fi
if [ ! -d "$1" ]; then
    echo "The specified path does not seem valid."
    exit 1
fi
ipod_path=$1

echo "Removing old files from the iPod..."
rm ${ipod_path}/*.mp3
rm ${ipod_path}/iPod_Control/iTunes/*
rm ${ipod_path}iPod_Control/Music/*
rm ${ipod_path}iPod_Control/Speakable/*

echo -e "Copying new files to the iPod...\n"
minfree=51200
freespace=$(df "${ipod_path}" | awk 'FNR>1{print $4}')
while [ $freespace -gt $minfree ]; do
    path="$(shuf -zen1 ~/Musica/*.mp3)"
    size=$(echo -e $(ls -l "${path}" | awk '{ print $5 }')/1024 | bc)
    if [ $size -lt $minfree ]; then
        echo Now copying file: $(basename "${path}")
    	cp "${path}" "${ipod_path}"
    fi
    freespace=$(df "${ipod_path}" | awk 'FNR>1{print $4}')
done

echo -e "\nNow rebuilding the iPod's iTunesDB...\n"
sleep 3

chmod +x ./rebuild_db.py
./rebuild_db.py "${ipod_path}"
