#!/bin/bash

set -euo pipefail

CORE_SETTINGS="./core/settings"
TEMPLATE_FOLDER="./templates"
PROJECT_NAME="django-setup-template"

function init() {
  test -d ${PROJECT_NAME} || git clone https://github.com/theArtechnology/${PROJECT_NAME}.git
  cp -R ${PROJECT_NAME}/* .
}

function setup_python() {
  test -d .venv || python3 -m venv .venv
  . .venv/bin/activate
  pip install -r requirements.txt
  make requirements
}


function setup_core_project() {
    test -d core || django-admin startproject core .
    mkdir ${CORE_SETTINGS}
    touch ${CORE_SETTINGS}/{__init__.py,defaults.py,prod.py,dev.py,staging.py}
    awk 'NR==16 {$0="BASE_DIR = Path(__file__).resolve().parent.parent.parent"} { print }' ${CORE_SETTINGS}.py >  ${CORE_SETTINGS}/defaults.py 
}


function create_files_from_templates() {
    cat ${TEMPLATE_FOLDER}/README.md > README.md
    cat ${TEMPLATE_FOLDER}/init.py > ${CORE_SETTINGS}/__init__.py
    cat ${TEMPLATE_FOLDER}/dev.py > ${CORE_SETTINGS}/dev.py
    cat ${TEMPLATE_FOLDER}/prod.py > ${CORE_SETTINGS}/prod.py
    cat ${TEMPLATE_FOLDER}/staging.py > ${CORE_SETTINGS}/staging.py
}

function clean_up() {
    rm ${CORE_SETTINGS}.py
    rm -rf ${PROJECT_NAME}
    rm install.sh
    rm -rf ${TEMPLATE_FOLDER}
}


init
setup_python
setup_core_project
create_files_from_templates
clean_up
