#!/bin/bash
PGPASSWORD=postgres psql -U postgres postgres -f modules/MODULE_ACCESS.sql