#!/bin/bash

####### Path #######
HERE=$(cd $(dirname $BASH_SOURCE:-0); pwd)
# input
MOVIE_NAME=movie_name
MOVIE_PATH=${HERE}/input/20190816/${MOVIE_NAME}.mp4
MOVIE_SPLIT_TMP_PATH=${HERE}/input/tmp
mkdir -p ${MOVIE_SPLIT_TMP_PATH}
# output
OUTPUT_PATH=${HERE}/output/${MOVIE_NAME}
OUTPUT_IMG_PATH=${OUTPUT_PATH}/img
mkdir -p ${OUTPUT_IMG_PATH}
date=$(date '+%Y%m%d-%H%M%S')
OUTPUT_MOVIE_PATH=${OUTPUT_PATH}/${MOVIE_NAME}_{$date}.mp4
# output json
WITH_JSON=

####### 動画の分割 #######
ffmpeg -i ${MOVIE_PATH} -ss 0 -t 4 -vcodec png ${MOVIE_SPLIT_TMP_PATH}/image_%06d.png

####### 各フレームの回転処理 #######


####### hmrの実行 #######
for file in `\find ${MOVIE_SPLIT_TMP_PATH} -maxdepth 1 -type f`; do
    FILE_NAME=$(basename ${file})
    /opt/conda/envs/py27/bin/python -m demo --img_path ${file} --output_path ${OUTPUT_IMG_PATH}/${FILE_NAME}
done

####### 動画出力 #######
ffmpeg -r 60 -i ${OUTPUT_IMG_PATH}/image_%06d.png -c:v libx264 -pix_fmt yuv420p -vf "scale=trunc(iw/2)*2:trunc(ih/2)*2" $OUTPUT_MOVIE_PATH

####### 後処理 #######
rm -r ${MOVIE_SPLIT_TMP_PATH}
rm -r ${OUTPUT_IMG_PATH}

echo $SECONDS
