#!/bin/bash
CURRENT_UID=$(id -u):$(id -g) python3 manage.py migrate --verbosity 3
CURRENT_UID=$(id -u):$(id -g) python3 manage.py populatedb --createsuperuser --verbosity 3
