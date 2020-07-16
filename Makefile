PROJECT=nanorv32
SHELL := /bin/bash

mkvenv:
	. `which virtualenvwrapper.sh` && mkvirtualenv -p python3 $(PROJECT) && workon $(PROJECT)

freeze:
	pip freeze > requirements.txt

install_env:
	pip install -r requirements.txt

clang_complete:
	sed "s@XXXXX@$(PWD)@" ./common/clib/clang_complete.txt > .clang_complete
