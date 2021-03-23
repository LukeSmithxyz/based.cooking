#!/bin/sh
set -eu

SIZE_LIMIT=150000

check_size() {
	size="$(stat --printf="%s" "$1")"
	if [ "$size" -gt "$SIZE_LIMIT" ]; then
		echo "File $1 is bigger than specified $SIZE_LIMIT limit"
		exit 1
	fi
}

check_webp_name() {
	shouldname="$(echo "$1" |
		iconv --to-code=utf-8 |
		sed "s/^\(data\/pix\/\)\?/data\/pix\//" |
		tr '[:upper:]' '[:lower:]' |
		tr '_ ' '-')"
	if [ "$shouldname" != "$1" ]; then
		echo "$1 should be named $shouldname."
		exit 1
	fi
}

check_recipe_name() {
	shouldname="$(echo "$1" |
		iconv --to-code=utf-8 |
		sed "s/^\(src\/\)\?/src\//" |
		tr '[:upper:]' '[:lower:]' |
		tr '_ ' '-')"
	if [ "$shouldname" != "$1" ]; then
		echo "$1 should be named $shouldname."
		exit 1
	fi
}

check_recipe_content() {
	awk '
		BEGIN {
			HAS_TITLE       = 0;
			HAS_TAGS        = 0;
			NUM_TAGS        = 0;
			HAS_INGREDIENTS = 0;
			HAS_DIRECTIONS  = 0;
		}

		# First line should be the title
		NR == 1 && /^# / {
			HAS_TITLE = 1;
			next;
		}

		/^## Ingredients/ {
			HAS_INGREDIENTS = 1;
			next;
		}

		/^## Directions/ {
			HAS_DIRECTIONS = 1;
			next;
		}

		END {
			# Last line should be the tags list
			if ($1 == ";tags:") {
				HAS_TAGS = 1;
				NUM_TAGS = NF - 1;
			}

			FAIL = 0;

			if (!HAS_TITLE) {
				print "Recipe does not have a properly formatted title on the first line."
				FAIL = 1;
			}

			if (!HAS_TAGS) {
				print "Recipe does not have a properly formatted tags on the last line."
				FAIL = 1;
			} else if (NUM_TAGS < 2) {
				print "Recipe only has " NUM_TAGS " tags. Add some more."
				FAIL = 1;
			} else if (NUM_TAGS > 5) {
				print "Recipe has " NUM_TAGS " tags which is too many. Remove some tags."
				FAIL = 1;
			}

			if (!HAS_INGREDIENTS) {
				print "Recipe does not have an ingredients list."
				FAIL = 1;
			}

			if (!HAS_DIRECTIONS) {
				print "Recipe does not have a directions section."
				FAIL = 1;
			}

			if (FAIL) {
				exit 1;
			}
		}
	' "$1"

	if [ $? -ne 0 ]; then
		exit 1;
	fi
}

git diff --name-only "$(git merge-base origin/master HEAD)" | while IFS= read -r file; do
	case "$file" in
		*.webp)
			echo "Checking size of $file"
			check_size "$file"
			check_webp_name "$file"
			;;
		.github/*.md)
			exit 0;
			;;
		*.md)
			check_recipe_name "$file"
			check_recipe_content "$file"
			;;
    esac
done
