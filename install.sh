#!/bin/bash

set -euo pipefail

function init() {
  test -d "./django-setup-template" || git clone https://github.com/theArtechnology/django-setup-template.git
  cp django-setup-template/* .

}

function setup_python() {
  test -d .venv || python3 -m venv .venv
  . .venv/bin/activate
  pip install -r requirements.txt
  make requirements
}


function setup_core_project() {
    test -d core || django-admin startproject core .
    mkdir ./core/settings
    touch ./core/settings/{__init__.py,defaults.py,prod.py,dev.py,staging.py}
    awk 'NR==16 {$0="BASE_DIR = Path(__file__).resolve().parent.parent.parent"} { print }' ./core/settings.py >  ./core/settings/defaults.py 

}


function create_files_from_templates() {
    cat templates/README.md > README.md
    cat templates/init.py > ./core/settings/__init__.py
    cat templates/dev.py > ./core/settings/dev.py
    cat templates/prod.py > ./core/settings/prod.py
    cat templates/staging.py > ./core/settings/staging.py
}

function clean_up() {
    rm ./core/settings.py
    rm -rf django-setup-template
    rm install.sh
    rm -rf templates
}


init
setup_python
setup_core_project
create_files_from_templates
clean_up