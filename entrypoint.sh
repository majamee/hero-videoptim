#!/bin/bash
mkdir -p "/tmp/video/";
shopt -s nullglob;

echo -e "\e[7mPlease be aware, that the audio track of all videos in provided folder will be cut. Due to that, originals will be kept renamed.";
echo -e "\n\e[5mProcessing ${1}\n";
cd /video/$1;
for file in *
do
    if [ -d "${file}" ] ; then
        /bin/entrypoint.sh "${1}/${file}";
    else 
        if ( [ ${file: -4} == ".avi" ] || [ ${file: -4} == ".mkv" ] || [ ${file: -4} == ".mp4" ] || [ ${file: -4} == ".wmv" ] || [ ${file: -4} == ".ts" ] || [ ${file: -4} == ".mov" ] || [ ${file: -4} == ".flv" ] || [ ${file: -4} == ".webm" ] ); then
            if grep -Fxq "${file}" /video/.hero-videoptim
            then
                echo -e "\e[104m${file} already optimized in previous run. Skipping";
                continue
            fi
            
            rm -rf "/tmp/video/*";
            ffmpeg -y -threads 4 -i "${file}" -an -c:v libx264 -x264opts 'keyint=24:min-keyint=24:no-scenecut' -profile:v high -level 4.0 -vf "scale=min'(1920,iw)':-4" -crf 22 -movflags faststart -write_tmcd 0 "/tmp/video/${file}"; 
            if [ ${PIPESTATUS[0]} -eq 0 ]; then
                oldsize=$(wc -c <"${file}");
                newsize=$(wc -c <"/tmp/video/${file}");
                if [ $newsize -lt $oldsize ]; then
                    chown `stat -c "%u:%g" "${file}"` "/tmp/video/${file}";
                    chmod `stat -c "%a" "${file}"` "/tmp/video/${file}";
                    mv "${file}" "${file}.backup";
                    mv "/tmp/video/${file}" "${file}";
                else
                    echo -e "\e[41mOptimized file for ${file} is not smaller. Skipping";
                fi
            else
                echo -e "\e[101mOptimizing file ${file} failed. Skipping";
            fi
            
            echo "${file}" >> /video/.hero-videoptim;
            echo -e "\e[42mOptimized file \e[1m${file} \e[21msuccessfully as hero-video";
        fi
    fi
done
