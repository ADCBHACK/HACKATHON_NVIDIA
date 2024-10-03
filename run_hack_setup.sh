#!/bin/bash

mkdir -p $PWD/hack

curl -L "https://raw.githubusercontent.com/ADCBHACK/HACKATHON_NVIDIA/refs/heads/main/CV%20Match/CV_Match_Starter.ipynb" -o $PWD/hack/CV_Match_Starter.ipynb
curl -L "https://raw.githubusercontent.com/ADCBHACK/HACKATHON_NVIDIA/refs/heads/main/Real%20Estate/Real_Estate_Starter.ipynb" -o $PWD/hack/Real_Estate_Starter.ipynb
curl -L "https://raw.githubusercontent.com/ADCBHACK/HACKATHON_NVIDIA/refs/heads/main/Stock%20Market/Stock_Market_Starter.ipynb" -o $PWD/hack/Stock_Market_Starter.ipynb

docker stop $(docker ps -a -q)

docker run \
    --rm \
    -it \
    --pull always \
    --gpus all \
    -p 8888:8888 \
    --shm-size=1g --ulimit memlock=-1 --ulimit stack=67108864 \
    -e EXTRA_PIP_PACKAGES="langchain_nvidia_ai_endpoints" \
    -e NB_PREFIX="/notebook" \
    -v $PWD/hack:/home/rapids/notebooks/hack \
    rapidsai/notebooks:24.08-cuda11.8-py3.9
