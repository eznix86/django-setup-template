.PHONY: help

help: ## [host] makefile help description
	@egrep -h '\s##\s' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-10s\033[0m %s\n", $$1, $$2}'
%:
	@

db-makemigrations:  ## create migration files from models
	manage.py makemigrations

db-migrate: ## apply migration files to db
	manage.py migrate

db-clear:
	manage.py sqlflush | manage.py dbshell

static: ## collect static files
	manage.py collectstatic 

create-app: ## create an app <appname>
	manage.py startapp $(filter-out $@,$(MAKECMDGOALS))

create-admin: ## create a super user
	manage.py createsuperuser

update-password: ## change user password <username>
	manage.py changepassword $(filter-out $@,$(MAKECMDGOALS))

start: ## start server
	ENV=dev manage.py runserver

requirements: ## run pip freeze > requirements.txt
	pip freeze > requirements.txt