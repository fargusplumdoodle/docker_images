#!/bin/bash
REGISTRY=hub.sekhnet.ra

OPTION=$1

# Builds all docker images in this repo
# depending on if the version in package.json
# exists in the registry
#
# Options:
#   --no-push       Program will only build the images
#   --build         Program will build all of the images
#                   regardless of if its needed or not
#


function get_current_tag() {
   jq .version ./images/$APP_NAME/package.json | sed 's/"//g'
}

function get_current_image() {
   echo $REGISTRY/$APP_NAME:$(get_current_tag $APP_NAME)
}

function image_already_exists() {
   docker manifest inspect $IMAGE &> /dev/null
   return $?
}


function build_and_push() {
    local latest_image="$REGISTRY/$APP_NAME:latest"
    docker pull $latest_image || true
    docker build -t "$IMAGE" -t $latest_image --cache-from $latest_image .
    if [ $? -eq 0 ] && [ $OPTION = "--no-push" ];
    then
       docker image push $IMAGE
       docker image push $latest_image
    fi
}


for dir in ./images/*
do
    APP_NAME=$(basename $dir)
    IMAGE_DIR=$dir
    IMAGE=$(get_current_image)

    printf "$IMAGE"
    if $(image_already_exists) && ! [ $OPTION = '--build' ];
    then
	printf " ...exists\n"
    else
	printf " ...needs build\n\n\n"
	(cd $IMAGE_DIR; build_and_push)
    fi

done
