#!/bin/bash

docker compose pull && docker compose up -d

images=$(docker compose images --format json \
  | jq -r 'map(.Repository + ":" + .Tag)| unique | .[]') 

echo $images

imagesToSave=()

for image in $images; do
  if [[ $image == ghcr.io/ust-demaf/* ]]; then
    imageName=$(echo $image | cut -d'/' -f 3 | cut -d':' -f 1)
    newImageName=demaf/${imageName}:dummyImageTag
    docker image tag $image $newImageName
    imagesToSave+=("${newImageName}")
  else
    imagesToSave+=("${image}")
  fi
done

imagesToSaveFlattened=$(IFS=$'\n' echo ${imagesToSave[*]})
echo $imagesToSaveFlattened

docker save -o images.tar $imagesToSaveFlattened