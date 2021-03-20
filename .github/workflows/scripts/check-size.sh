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

git diff --name-only `git merge-base origin/master HEAD` | while IFS= read -r file; do
    case "$file" in
        *.webp)
            echo "Checking size of $file"
            check_size $file
            ;;
        *)
            echo "Skipping $file"
            ;;
    esac
done

