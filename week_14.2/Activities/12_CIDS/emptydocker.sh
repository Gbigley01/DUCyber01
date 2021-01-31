#!/bin/bash
# This script is for troubleshooting container issues. It simply removes all set docker containers, images, etc.
sudo docker ps -aq
sudo docker stop $(sudo docker ps -aq)
sudo docker rm $(sudo docker ps -aq)
sudo docker rmi $(sudo docker images -q)