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
fetch teachers_depts.sql
fetch classes_sched_students.sql

echo "OK"

