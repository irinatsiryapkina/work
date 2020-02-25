#!/usr/bin/env bash

psql -d wte -h walter.nrel.gov -f create_data_views.psql && python create_variable_views.py && psql -d wte -h walter.nrel.gov -f create_variable_views.psql
