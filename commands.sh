#!/usr/bin/env bash
set -ex
set -o pipefail

run(){
  docker-compose build
  docker-compose up
}

"$@"