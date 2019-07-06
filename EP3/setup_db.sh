#!/bin/bash
PGPASSWORD=postgres psql -U postgres postgres -f modules/MODULE_ACCESS_CLEAN.sql
PGPASSWORD=postgres psql -U postgres postgres -f modules/MODULE_ACCESS_DDL.sql
PGPASSWORD=postgres psql -U postgres postgres -f modules/MODULE_ACCESS_FUNCTIONS.sql
PGPASSWORD=postgres psql -U postgres postgres -f modules/MODULE_ACCESS_DML.sql
