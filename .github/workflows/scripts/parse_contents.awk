#!/usr/bin/gawk -f

# Check for Markdown titles
/^# / {
    if (NR == 1) {
        HAS_VALID_TITLE++;
    } else {
        NUM_INVALID_TITLES++;
    }
}

$0 == "## Ingredients" {
    NUM_INGREDIENTS++;
}

$0 == "## Directions" {
    NUM_DIRECTIONS++;
}

# Empty line
$0 == "" {
    # Count how many consecutive empty lines we have seen
    CONSECUTIVE_EMPTY_LINES++

    # If we have seen 2 or more then we are currently inside of a series of
    # consecutive empty lines
    if (INSIDE_CONSECUTIVE_EMPTY_LINES == 0 && CONSECUTIVE_EMPTY_LINES >= 2) {
        NUM_CONSECUTIVE_EMPTY_LINES++;
        INSIDE_CONSECUTIVE_EMPTY_LINES = 1;
    }
}

# If this current line is not an empty line, but we were just inside a
# consecutive empty line, then we have transitioned
$0 != "" {
    CONSECUTIVE_EMPTY_LINES = 0;
    INSIDE_CONSECUTIVE_EMPTY_LINES = 0;
}

# check lines with images. Some files have links to QR codes which I will
# ignore. Those are not part of this repo though, so they have https:// URLs. So
# ignore lines with http(s)
/\.webp/ && $0 !~ /https?:\/\// {
    # Name regexes, to make it easier to read
    EVERYTHING_UNTIL_NEXT_BRACKET = "[^\\]]*";
    EVERYTHING_UNTIL_NEXT_DOT = "[^.]+";
    EVERYTHING_UNTIL_NEXT_QUOTE = "[^\"]+";

    IMAGE_PATH = "pix/" EVERYTHING_UNTIL_NEXT_DOT "\\.webp";
    OPTIONAL_TITLE = "( \"" EVERYTHING_UNTIL_NEXT_QUOTE "\")?";

    IMAGE_REGEX = "!\\[" EVERYTHING_UNTIL_NEXT_BRACKET "\\]\\(" IMAGE_PATH OPTIONAL_TITLE "\\)";

    # If this does not have a properly formatted markdown image reference
    if ($0 !~ IMAGE_REGEX) {
        NUM_INVALID_IMAGE_INCLUSION++;
    } else {
        # If we do have a properly formatted image reference, check to see if
        # the image we are referencing actually exists.
        match($0, "(" IMAGE_PATH ")", pathArr)
        path = "data/" pathArr[1];
        if (system("test -f " path) != 0) {
            print "Recipe loads the image '" path "', but no such image exists. Remove this reference, or add this image to the PR.";
        }
    }
}

# Matches lines that end with whitespace
/\s$/ {
    NUM_TRAILING_WHITESPACE++;
}

# Matches a tab character that is preceded by a non tab character (ie, matches a
# tab that isn't used to indent a line)
/[^\t]+\t/ {
    NUM_NON_INDENTING_TAB++;
}

END {
    # Last line should be the tags list
    if ($1 == ";tags:") {
        HAS_TAGS = 1;
        NUM_TAGS = NF - 1;

        # Loop through all the tags
        # Start at field 2 because field 1 is ;tags:
        for (field = 2; field <= NF; field++) {
            # Make sure that each tag only contains lowercase letters and hyphens
            if ($field !~ "^[a-z-]+$") {
                NUM_INVALID_TAGS++;
            }
        }
    }

    if (!HAS_VALID_TITLE) {
        print "Recipe does not have a properly formatted title on the first line."
    }

    if (NUM_INVALID_TITLES > 0) {
        print "Recipe has " NUM_INVALID_TITLES " invalid titles. A title (line beginning with one '#') should only be on the first line of the recipe."
    }

    if (!HAS_TAGS) {
        print "Recipe does not have a properly formatted tags on the last line."
    } else {
        if (NUM_INVALID_TAGS > 0) {
            print "Recipe has " NUM_INVALID_TAGS " invalid tags. Tags must be separated by spaces and contain only lowercase letters or hyphens (-)";
        }

        if (NUM_TAGS < 2) {
            print "Recipe only has " NUM_TAGS " tags. You need between 2 and 5."
        } else if (NUM_TAGS > 5) {
            print "Recipe has " NUM_TAGS " tags which is too many. You need between 2 and 5."
        }
    }

    if (NUM_INGREDIENTS != 1) {
        print "Recipe has " NUM_INGREDIENTS " ingredients sections. Every recipe must have exactly 1 ingredients section."
    }

    if (NUM_DIRECTIONS != 1) {
        print "Recipe has " NUM_DIRECTIONS " directions sections. Every recipe must have exactly 1 directions section."
    }

    if (NUM_CONSECUTIVE_EMPTY_LINES > 0) {
        print "Recipe has " NUM_CONSECUTIVE_EMPTY_LINES " group(s) of of consecutive empty lines.";
    }

    if (NUM_INVALID_IMAGE_INCLUSION == 1) {
        print "Recipe has 1 image that isn't being included correctly. Look at other recipes to see how they are included. Note that the image path should NOT start with 'data/'";
    } else if (NUM_INVALID_IMAGE_INCLUSION >= 2) {
        print "Recipe has " NUM_INVALID_IMAGE_INCLUSION " images that aren't being included correctly. Look at other recipes to see how they are included. Note that the image path should NOT start with 'data/'";
    }

    if (NUM_TRAILING_WHITESPACE > 0) {
        print "Recipe has " NUM_TRAILING_WHITESPACE " line(s) with trailing whitespace (spaces/tabs etc at the end of lines). Please remove them.";
    }

    if (NUM_NON_INDENTING_TAB > 0) {
        print "Recipe has " NUM_NON_INDENTING_TAB " line(s) with tab characters that aren't at the beginning of the line. Please remove them."
    }
}
