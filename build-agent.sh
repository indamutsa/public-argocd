#!/bin/bash

# exit when any command fails
set -e

new_ver=$1
old_ver=$2

echo "new version: $new_ver"

# docker pull indamutsa/nginx:v1.0.3

# Simulate release of the new docker images
docker tag indamutsa/nginx:$old_ver indamutsa/nginx:$new_ver

# Push new version to dockerhub
docker push indamutsa/nginx:$new_ver

# Create temporary folder
tmp_dir=$(mktemp -d)
echo $tmp_dir

# Clone GitHub repo
# git clone https://github.com/indamutsa/argocd-helm-terraform.git $tmp_dir

# Update image tag
sed -i -e "s/indamutsa\/nginx:.*/indamutsa\/nginx:$new_ver/g" /home/arsene/Project/cloud-projects/ArgoCD/app/1-deployment.yaml


# Commit and push
# cd $tmp_dir
git pull
git add . ; git commit -m "Updated the repo by pulling from git!"
git add .
git commit -m "Update image to $new_ver"
git push

# Optionally on build agents - remove folder
# rm -rf $tmp_dir
