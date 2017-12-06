#!/bin/bash
shopt -s nullglob

echo "Processing ${1}";
cd /caesium/$1;
for file in *
do
    if [ -d "${file}" ] ; then
        /caesiumbin/entrypoint.sh "${1}/${file}";
    else 
        if ( [ ${file: -4} == ".png" ] || [ ${file: -4} == ".jpg" ] ); then
            rm -rf "/tmp/caesium/*";
            caesiumclt -q 80 -o "/tmp/caesium/" "${file}" | cat; # suppress segmentation faults from caesium for the time beeing
            if [ ${PIPESTATUS[0]} -eq 0 ]; then
                cp "/tmp/caesium/${file}" "${file}";
            else
                echo "Optimizing file ${file} failed. Skipping";
            fi
        fi
    fi
done