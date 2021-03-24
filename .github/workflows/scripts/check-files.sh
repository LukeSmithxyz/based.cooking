#!/bin/sh
set -eu

SIZE_LIMIT=150000
FAIL=0
errMsgs=''

check_size() {
	size="$(stat --printf="%s" "$1")"
	if [ "$size" -gt "$SIZE_LIMIT" ]; then
		echo "File $1 is bigger than specified $SIZE_LIMIT limit"
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
	fi
}

check_webp_name() {
	check_file_name "$1" "data/pix"
}

check_recipe_name() {
	check_file_name "$1" "src"
}

check_recipe_content() {
	if file "$1" | grep -qF 'CRLF'; then
		echo "Recipe has CRLF line endings. Please convert using dos2unix or similar tool.";

		# Stop checking file. The rest of the checks will have lots of failures
		# if we have CRLF line endings.
		return;
	fi

	errMsgs="$(gawk -f '.github/workflows/scripts/parse_contents.awk'  "$1")"

	if [ -n "$errMsgs" ]; then
		echo "$errMsgs"
	fi
}

check_image() {
	check_size "$1"
	check_webp_name "$1"
}

check_recipe() {
	check_recipe_name "$1"
	check_recipe_content "$1"
}

while IFS= read -r file; do
	# If the file doesn't exist, then the user probably deleted it, so don't
	# check it.
	# This will also ignore things that aren't files, like if someone adds a
	# folder
	if [ ! -f "$file" ]; then
		continue;
	fi

	case "$file" in
		# Ignore these files
		# Don't ignore all .md files in root, because otherwise we can't catch
		# recipe files that are placed in the wrong place.
		index.md) ;;
		example.md) ;;
		README.md) ;;
		.github/*.md) ;;

		*.webp)
			errMsgs="$(check_image "$file")"
			;;
		*.md)
			errMsgs="$(check_recipe "$file")"
			;;
	esac

	if [ -n "$errMsgs" ]; then
		echo "Errors Found in '$file'"
		echo "$errMsgs"
		echo ""
		FAIL=1
	fi
done <<EOF
$(git diff --name-only "$(git merge-base origin/master HEAD)")
EOF

exit $FAIL
