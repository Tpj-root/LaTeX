#!/bin/bash

# Script Name: plan.sh
# Description: A brief description of what the script does.
# Author: Your Name
# Date: 

# --- Global Variables (Optional) ---
# EXAMPLE_VAR="Hello World"

# --- Functions ---

function greet_user() {
  local name="$1"
  echo "Hello, $name!"
}

# --- Main Program ---

# if [[ -z "$1" ]]; then
#   echo "Usage: $0 <name>"
#   exit 1
# fi
# 
# greet_user "$1"



#------------------------
#
# author url 
#
#------------------------


# https://texample.net/author/kazuma/
# <a href="https://texample.net/regular-hexagonal-prism/" rel="bookmark">Regular Hexagonal Prism</a>


author() {
    local BASE="$1"
    local AUTHOR

    # extract author name from URL: https://texample.net/author/kazuma/
    AUTHOR=$(echo "$BASE" | awk -F'/' '{print $(NF-1)}')

    local html
    html=$(curl -s "$BASE")

    echo "SLNO, $AUTHOR, url, Headline"

    local i=1
    echo "$html" |
    grep -oP '<a href="https://texample.net/[^"]+" rel="bookmark">[^<]+' |
    while IFS= read -r line; do
        local url title
        url=$(echo "$line" | grep -oP 'https://[^"]+')
        title=$(echo "$line" | sed -e 's/.*">//')
        echo "$i, $AUTHOR, $url, $title"
        i=$((i+1))
    done
}


# author https://texample.net/author/kazuma/


#------------------------

#------------------------
#
# Project url 
# https://texample.net/regular-hexagonal-prism/
#------------------------




project() {
    local URL="$1"
    local html=$(curl -s "$URL")

    # folder name = last part of URL
    local slug=$(basename "$URL")
    mkdir -p "$slug"

    # 1. extract <pre>...</pre> (TeX code)
    echo "$html" | sed -n '/<pre>/,/<\/pre>/p' \
                  | sed 's/<pre>//; s/<\/pre>//' \
                  > "$slug/$slug.tex"

    # 2. extract PNG link
    local img=$(echo "$html" | grep -oP 'https://texample.net/wp-content/uploads[^"]+\.png' | head -1)

    # download PNG
    if [[ -n "$img" ]]; then
        curl -s -o "$slug/$(basename "$img")" "$img"
    fi

    # 3. extract datePublished
    local date=$(echo "$html" | grep -oP 'datePublished">[^<]+' | sed 's/datePublished">//')

    # 4. extract entry-author-name
    local author=$(echo "$html" | grep -oP 'entry-author-name"[^>]*>[^<]+' | sed 's/.*>//')

    # output the 3 results
    echo "image_url: $img"
    echo "datePublished: $date"
    echo "author: $author"
}






# project https://texample.net/regular-hexagonal-prism/






#------------------------
#
# Categories url 
# https://texample.net/science/
# https://texample.net/category/science-technology/biology/

# https://texample.net/category/other-areas/ 22*3 + 1 = 67
#------------------------



# https://texample.net/category/other-areas/
# Firefox script





#------------------------
#
# authors_data url 
# https://texample.net/authors/
#------------------------


authors_data() {
    local URL="$1"
    local html=$(curl -s "$URL")

    echo "URL, post_count"

    echo "$html" |
    tr '\n' ' ' |
    grep -oP '<div class="authors-list-item[^>]*>.*?<div class="authors-list-item-subtitle">[^<]+' |
    while read -r block; do
        local link=$(echo "$block" | grep -oP 'https://texample.net/author/[^"]+')
        local count=$(echo "$block" | grep -oP 'authors-list-item-subtitle">[^<]+' | sed 's/.*">//; s/ posts//')

        echo "$link, $count"
    done
}

# authors_data https://texample.net/authors/




exit 0
