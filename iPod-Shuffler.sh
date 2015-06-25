#!/bin/bash
if [ -z "$1" ]; then
    echo "[ERR] Please pass the full path to the iPod folder (without trailing slash) as the first parameter."
    exit 1
fi
ipod_path="$1"
if [ ! -d "${ipod_path}" ]; then
    echo "[ERR] The specified path does not seem valid."
    exit 1
fi

echo -ne "[*] Removing old files from the iPod...\r"
rm -r "${ipod_path}"/*
echo "[#] Removed old files from the iPod    "

echo -ne "[*] Generating folder structure...\r"
mkdir "${ipod_path}"/iPod_Control
mkdir "${ipod_path}"/iPod_Control/iTunes
mkdir "${ipod_path}"/iPod_Control/Music
mkdir "${ipod_path}"/iPod_Control/Speakable
echo "[#] Folder structure generated    "

echo -e "[*] Copying new files to the iPod..."
minfree=51200
freespace=$(df "${ipod_path}" | awk 'FNR>1{print $4}')
while [ $freespace -gt $minfree ]; do
    path="$(shuf -zen1 ~/Musica/*.mp3)"
    size=$(echo -e $(ls -l "${path}" | awk '{ print $5 }')/1024 | bc)
    if [ $size -lt $minfree ]; then
        echo "    [+] Now copying file: $(basename "${path}")"
    	cp "${path}" "${ipod_path}"
    fi
    freespace=$(df "${ipod_path}" | awk 'FNR>1{print $4}')
done
echo "[#] New files copied successfully"
echo "[*] Now rebuilding the iPod's iTunesDB..."
~/bin/./shuffle.py "${ipod_path}"
