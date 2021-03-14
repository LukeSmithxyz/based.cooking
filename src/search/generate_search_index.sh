#!/bin/bash

URL="https://based.cooking"

# generate search indices next to 'generate_search_index.sh'
search_dir=$(dirname "$0")

# before regenerating search indices
# clean search directory except 'generate_search_index.sh'
find $search_dir ! -name `basename $0` -type f -delete

# list all recipes in src/
for filepath in $search_dir/../*.md; do
    # grab filename of the recipe
    filename=$(basename $filepath)

    # grab filename of the recipe WITHOUT it's extension: '.md'
    title=${filename%.*}

    # split title into words delimited by dash '-'
    title_delimited=$(echo $title | tr '-' "\n")

    # iterate over each word in the title
    for word in $title_delimited; do
        # for each word, create a new file that contains links to it's recipes
        echo "$URL/$title.html" >> $search_dir/$word
    done
done
