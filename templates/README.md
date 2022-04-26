Title
================

## System requirements

* Python >= 3.9
* Postgres Development Package
    * `sudo apt-get install libpq-dev` on linux
    * `brew install postgresql` on mac


# Quick Info


Local development -> username: `admin` and password: `admin`

## Project Content
* core
    * This is core folders of the django app
    * in `settings` module you will find every environment settings. Base configuration is found in `defaults.py`
* .env.dist
    * It should not be used as is. Copy and paste and rename to `.env`
    * It is for templating purpose
* Makefile 
    * It contains shortcuts as commands
* Procfile 
    * A file used for heroku (staging environment)
* requirements.txt
    * Contains list of package to make the project work


## Project Development Setup

Using the development setup, you should clone the project.

You can checkout the Makefile to see what is going on.

Run:

```bash

make # This will show what's inside

```

**Steps**

```sh
source .venv/bin/activate # activate it

pip install -r requirements.txt

make db-makemigrations
make db-migrate

make start

```


## Project generated Links for Development

* localhost:8000

## Deployment

- Staging
    - ...

- Prod
    - ...


## How to commit ?

Every development is based on the `main` branch.


* Conventions should be respected
    * **No direct merge on dev branch**
    * **Respect branches names**
    * **Use good descriptions for branches names**
* Pull requests are sub branch of `main`
* Branch name layout
    * [type]_[description/issue-number]
    * Types:
        * `feat`, `fix`, `hotfix`, `enh`
    * Description/Issue-Number separated by underscore
        * 001
        * added_user_model
    * Example:
        * feat_add_user_model
        * fix_003