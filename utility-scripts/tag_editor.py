"""
Tag Editor provides an easy interface to edit every reipies' tags sequentially. 

This is useful if you want to, for example, add gluten-free tags to recipes en masse.

Useage:

[add / a / +] {tags} - add tag(s)
[remove / r / -] {tags} - remove tag(s)
[next / n / ""] - move to next item, writing any changes
[quit/ q] - exit the program early

@ Author: @DollarStarNova
@ Version: 1.0_2021-03-24
@ License: Public Domain (CC-0)

"""


import os  # scandir, system, pardir
import pathlib
import sys  # exit
import codecs

recipe_path = pathlib.Path(pathlib.Path(__file__).parents[1], "src")
list_of_ingredient_first_characters = ["-", "*"]


def list_ingredients(recipe_lines: list) -> list:
    ingredients = ["No Ingredients Found"]
    add_ingredient = False
    for line in recipe_lines:
        if line[:14] == "## Ingredients":
            ingredients = []
            add_ingredient = True
            continue
        if add_ingredient:
            if line.strip(" ")[0] in list_of_ingredient_first_characters:
                ingredients.append(line[1:].strip())
            elif (
                line[0:3] == "## "
            ):  # check for next catagory of equal indentation (allows for subcatagories in ingredient lists)
                add_ingredient = False
    return ingredients


def read_write_tags(recipe_lines: list, tags: list = None) -> [list, list]:
    """
    Inputs: [recipe_lines: list, tags: list = None]
                parses the recipe_lines list for a ";tags:" line and, if found:
                    * If tags is None, stores them in tags
                    * Else replaces recipe_lines tag line with tags

    Outputs: [recipe_lines: list, tags: list]
                    * If tags input is None, returns [tags], [recipe_lines] - recipe lines is not modified
                    * Else returns [tags], [recipe_lines] - tags is not modified, recipe_lines is modified to add / remove tags

    """
    if tags is None:
        tags = []
        for line in recipe_lines:
            if line[:6] == ";tags:":
                tags = line[7:].split(" ")
                tags[-1] = tags[-1].strip(
                    "\n"  # We need to strip out the newline to make the tags list work properly
                )
    else:
        tags[-1] = f"{tags[-1]}\n"  # Adding back in the newline we stripped out earlier
        for line in range(len(recipe_lines)):
            if recipe_lines[line][:6] == ";tags:":
                recipe_lines[line] = ";tags: " + " ".join(tags)
    return recipe_lines, tags


if __name__ == "__main__":

    with os.scandir(recipe_path) as recipes:
        for recipe in recipes:
            changes_made = False
            tags = []
            recipe_lines = ""
            with open(
                os.path.join(recipe_path, recipe.name), "r", encoding="utf-8"
            ) as current_recipe:
                recipe_lines, tags = read_write_tags(current_recipe.readlines())
                ingredients = "\n* " + "\n* ".join(list_ingredients(recipe_lines))

                command = []
                command.append(None)
                next_commands = ["next", "n", ""]
                while not command[0] in next_commands:
                    os.system("cls" if os.name == "nt" else "clear")
                    print(f"Current recipe: {recipe.name}")
                    print(f"recipe Ingredients: {ingredients}")
                    print(f"Current tags: {tags}")
                    command = input("add/remove {tag tag tag...} or next >> ").split(
                        " "
                    )

                    if command[0] in ["quit", "q"]:
                        sys.exit(0)
                    if command[0] in ["add", "a", "+"]:
                        del command[0]
                        tags = tags + list(
                            filter(None, command)
                        )  # prevent empty strings
                        changes_made = True
                    if command[0] in ["remove", "r", "-"]:
                        del command[0]
                        for tag in command:
                            if tag in tags:
                                tags.remove(tag)
                        changes_made = True
            if changes_made:
                recipe_string = "".join(read_write_tags(recipe_lines, tags)[0])
                with open(
                    os.path.join(recipe_path, recipe.name), "w", encoding="utf-8"
                ) as current_recipe:
                    current_recipe.writelines(recipe_string)