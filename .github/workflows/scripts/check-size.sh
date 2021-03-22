#!/bin/sh
set -eu

SIZE_LIMIT=150000

check_size() {
    local size=$(stat --printf="%s" $1)
    if [ "$size" -gt "$SIZE_LIMIT" ]; then
        echo "File $1 is bigger than specified $SIZE_LIMIT limit"
        exit 1
    fi
}

check_md_name() {
	shouldname="$(echo "$1" |
		iconv --to-code=utf-8 |
		sed "s/^\(src\/\)\?/src\//" |
		tr '[:upper:]' '[:lower:]' |
		tr ' ' '-')"
	if [ "$shouldname" != "$1" ]; then
		echo "$1 should be named $shouldname."
		exit 1
	fi
}

git diff --name-only `git merge-base origin/master HEAD` | while IFS= read -r file; do
    case "$file" in
        *.webp)
            echo "Checking size of $file"
            check_size $file
            ;;
	*.md) check_md_name "$file" ;;
    esac
done
