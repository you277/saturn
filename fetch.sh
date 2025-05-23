#!/bin/bash

# nohup ./fetch.sh > "sql_yay.log" &

# remember to set your user and pw

file_name=".temp_inserts.sql"
user=""
pw=""

if [ -z $user ]; then
        echo "remember to provide user name"
        exit 1
fi
if [ -z $pw ]; then
        echo "remember to provide pw"
        exit 2
fi

echo $db
echo "" > "$file_name"

function get_url() {
        echo "https://raw.githubusercontent.com/you277/saturn/refs/heads/main/data/$1"
}

function write() {
        echo "getting $1"
        url=$(get_url $1)
        curl -s -X GET "$url" > "$file_name"
        echo "got $1"
        echo "writing $1"
        mysql -u "$user" -p"$pw" -h 10.8.37.226 -D "${user}_db" < "$file_name"
        echo "wrote to $1"
        echo ""
}

# clear

write ONESTOPSHOP/cleartables.sql

# data population

write types.sql
write rooms.sql
write courses.sql

write classes.sql
write assignments.sql
write schedules.sql
write students.sql
write teachers_depts.sql

# grades insertion may just stop for some reason so edit to write whatever you still need to insert based on outputted log file

write grades/1.sql
write grades/2.sql
write grades/3.sql
write grades/4.sql
write grades/5.sql
write grades/6.sql
write grades/7.sql
write grades/8.sql

rm "$file_name"
echo "OK"
