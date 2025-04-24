#!/bin/bash

file_name="fetched_combined.sql"
echo "" > "$file_name"

function get_url() {
        echo "https://raw.githubusercontent.com/you277/saturn/refs/heads/main/data/$1"
}

function fetch() {
        echo "getting $1"
        url=$(get_url $1)
        curl -s -w "" "$url" >> "$file_name"
        echo "got $1"
}

fetch types.sql
fetch rooms.sql
fetch courses.sql

fetch classes.sql
fetch assignments.sql
fetch schedules.sql
fetch students.sql

fetch grades/1.sql
fetch grades/2.sql
fetch grades/3.sql
fetch grades/4.sql
fetch grades/5.sql
fetch grades/6.sql
fetch grades/7.sql
fetch grades/8.sql

fetch teachers_depts.sql

echo "OK"

