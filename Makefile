.PHONY: help

help: ## [host] makefile help description
	@egrep -h '\s##\s' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-10s\033[0m %s\n", $$1, $$2}'
%:
	@

env-gen: ## create environment
	test -d .venv || python3 -m venv .venv

db-makemigrations:  ## create migration files from models
	python manage.py makemigrations

db-migrate: ## apply migration files to db
	python manage.py migrate

db-clear:
	python manage.py sqlflush | python manage.py dbshell

static: ## collect static files
	python manage.py collectstatic 

create-app: ## create an app <appname>
	python manage.py startapp $(filter-out $@,$(MAKECMDGOALS))

create-admin: ## create a super user
	python manage.py createsuperuser

update-password: ## change user password <username>
	python manage.py changepassword $(filter-out $@,$(MAKECMDGOALS))

start: ## start server
	ENV=dev python manage.py runserver

requirements: ## run pip freeze > requirements.txt
	pip freeze > requirements.txt