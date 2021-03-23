#!/bin/sh
set -u

SIZE_LIMIT=150000
FAIL=0

check_size() {
	size="$(stat --printf="%s" "$1")"
	if [ "$size" -gt "$SIZE_LIMIT" ]; then
		echo "File $1 is bigger than specified $SIZE_LIMIT limit"
		FAIL=1
	fi
}

check_file_name() {
	fileName="$1"
	expectedFolder="$2"

	shouldname="${expectedFolder}/$(basename "$fileName" |
		iconv --to-code=utf-8 |
		tr '[:upper:]' '[:lower:]' |
		tr '_ ' '-')"

	if [ "$shouldname" != "$fileName" ]; then
		echo "$1 should be named $shouldname."
		FAIL=1
	fi
}

check_webp_name() {
	check_file_name "$1" "data/pix"
}

check_recipe_name() {
	check_file_name "$1" "src"
}

check_recipe_content() {
	awk '
		BEGIN {
			HAS_TITLE                   = 0;
			HAS_TAGS                    = 0;
			NUM_TAGS                    = 0;
			HAS_INGREDIENTS             = 0;
			HAS_DIRECTIONS              = 0;
			HAS_CONSECUTIVE_EMPTY_LINES = 0;

			CONSECUTIVE_EMPTY_LINES = 0;
		}

		# First line should be the title
		NR == 1 && /^# / {
			HAS_TITLE = 1;
			next;
		}

		$0 == "## Ingredients" {
			HAS_INGREDIENTS = 1;
		}

		$0 == "## Directions" {
			HAS_DIRECTIONS = 1;
		}

		$0 == "" {
			CONSECUTIVE_EMPTY_LINES++
			if (CONSECUTIVE_EMPTY_LINES >= 2) {
				HAS_CONSECUTIVE_EMPTY_LINES = 1;
			}
		}

		$0 != "" {
			CONSECUTIVE_EMPTY_LINES = 0;
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

			if (HAS_CONSECUTIVE_EMPTY_LINES) {
				print "Recipe has at least 2 consecutive empty lines.";
				FAIL = 1;
			}

			if (FAIL) {
				exit 1;
			}
		}
	' "$1"

	if [ $? -ne 0 ]; then
		FAIL=1
	fi
}

while IFS= read -r file; do
	echo "Checking '$file'"
	case "$file" in
		# Ignore these files
		index.md) ;;
		.github/*.md) ;;

		*.webp)
			echo "Checking size of $file"
			check_size "$file"
			check_webp_name "$file"
			;;
		*.md)
			check_recipe_name "$file"
			check_recipe_content "$file"
			;;
	esac
	# Separate each file for easier reading.
	echo ""
done <<EOF
$(git diff --name-only "$(git merge-base origin/master HEAD)")
EOF

exit $FAIL
