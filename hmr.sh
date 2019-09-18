#!/bin/bash

####### Path #######
export HERE=$(cd $(dirname $BASH_SOURCE:-0); pwd)
# input
export IMG_NAME=coco3
export IMG_PATH=data/${IMG_NAME}.png
# output
export OUTPUT_PATH=${HERE}/output/${IMG_NAME}
export OUTPUT_IMG_PATH=${OUTPUT_PATH}/${IMG_NAME}_output.png
mkdir -p ${OUTPUT_PATH}

# output json
export WITH_JSON=True
if [ ${WITH_JSON} = True ]; then
  export OUTPUT_JSON_PATH=${OUTPUT_PATH}/json
  mkdir -p ${OUTPUT_JSON_PATH}
fi

####### hmrの実行 #######
/opt/conda/envs/py27/bin/python -m demo --img_path ${IMG_PATH} --output_path ${OUTPUT_IMG_PATH}
