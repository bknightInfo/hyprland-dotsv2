#!/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

cd $SCRIPT_DIR/storage 
mkdir -pv framework/views app framework/sessions framework/cache 
cd .. 
chmod -R 777 storage