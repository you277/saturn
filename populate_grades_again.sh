#!/bin/bash

# because i messed up the initial grades count

file_name=".fix_data.sql"
user=""
pw=""

echo $db
echo "" > "$file_name"

function get_url() {
        echo "https://raw.githubusercontent.com/you277/saturn/refs/heads/main/data/$1"
}

function write() {
        echo "getting $1"
        url=$(get_url $1)
        curl -X GET "$url" > "$file_name"
        echo "got $1"
        echo "writing $1"
        mysql -u "$user" -p"$pw" -h 10.8.37.226 -D "${user}_db" < "$file_name"
        echo "wrote to $1"
}

write grades/1.sql
write grades/2.sql
write grades/3.sql
write grades/4.sql
write grades/5.sql
write grades/6.sql
wrote grades/7.sql
write grades/8.sql

rm "$file_name"
echo "OK"
