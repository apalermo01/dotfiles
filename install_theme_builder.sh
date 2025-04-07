#!/bin/bash

cd theme-builder
python -m venv env
source ./env/bin/activate && pip install -r requirements.txt
