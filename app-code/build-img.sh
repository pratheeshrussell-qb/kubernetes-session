#!/bin/bash

# build all images
# only to test in docker-compose
# only backend image is used for the kind setup
docker build -t quote-frontend ./frontend
docker build -t quote-backend ./backend
docker build -t quote-postgres ./postgres