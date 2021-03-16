# Based Cooking Website

[https://based.cooking](https://based.cooking)

## To-do

- get many recipes
- make and take pictures of recipes
- decide on CSS/styling, something good-looking and readable, but nothing too complicated
- search function? See below
- keep it simple

## Rules for submission

- Recipes should start with a title, with a single `#`, *on the first line*. No
  empty line at the top, not trailing line at the end. The file needs to be `\n`
  terminated in linux-fashion (if you're on linux you don't need to care, it
  should be automatic).
- Recipes should be `.md` files in the `src/` directory.  Look at already
  existing `.md` files for examples or see [example](example.md).
- File names should be the name of the dish with words separated by hyphens
  (`-`). Not underscores, and definitely not spaces.
- Recipe must be based, i.e. good traditional and substantial food. Nothing
  ironic, meme-tier hyper-sugary, meat-substitute, etc.
- Don't include salt and pepper and other ubiquitous things in the ingredients
  list.

**If you fail to do these things, I will close your submission and you will have to resubmit. I am tired of having to fix more than 50% of submissions.**

### Tags

You can (and should) add tags at the end of your recipe. The syntax is:
```
;tags: tag1 tag2 tag3
```

The tag line should be a single line, at the end of the markdown file, preceded
by a blank line.

Add between 1 and 4 tags, **prioritize existing tags**. As a general guideline,
add the country from which the recipe originates if the recipe is representative
of said country, using the adjective form (eg. *mexican*, *italian*, etc). Tag
the main ingredient if it's something slightly special.

List of special, categorical tags to use if relevant:
- `basic`: for basic recipes that aren't meant to be stand alone but are supposed
  to be incorporated in another recipe.
- `breakfast`
- `dessert`
- `drink`
- `quick`: for recipes that can be cooked in under ~20 minutes.
- `side`: side dishes such as mash, fries, etc.
- `snack`
- `spread`

### Images

Images are stored in `data/pix`.

Each recipe can have a title image at the top and perhaps
several instructional images as absolutely necessary.

Do not add stock images you found on the internet.
Take a good picture yourself of the actual dish created.
If you see a bad or substandard image, you may submit a better one.

Images should be in `.webp` format and with as small file size as possible.
If you submit an image for say, `chicken-parmesan.md`, it should be added as `pix/chicken-parmesan.webp`.
I will create smaller images from that which is seen on the page,
and upon being clicked, the user will see the full-size image.

If you would like to add additional directional images,
they should be numbered with two digits like: `pix/chicken-parmesan-01.webp`, etc.

## About the site

The front page, for now, will just be a list of recipes automatically generated
from the content of `src`.
As more articles are added, the site will be reorganized, categorized
or will implement server-side scripting or searches.
This is not necessary yet though.

I don't really want images of recipes on the mainpage yet.
I'll think about how best to do it to minimize bandwidth if possible.

## curl/Search function

So suppose someone wants a recipe with chicken, to return articles with that title:
```bash
$ curl based.cooking/chicken

https://based.cooking/chicken-biscuit-potpie.html
https://based.cooking/chicken-parmesan.html
https://based.cooking/chicken-pasta-casserole.html
https://based.cooking/chicken-stock-bone-broth.html
https://based.cooking/chicken-tacos.html
https://based.cooking/chicken-tomato-spinach-curry.html
https://based.cooking/chicken-wings.html
https://based.cooking/pan-seared-chicken.html
https://based.cooking/roasted-chicken-breast.html
```

Works with tags too:

```bash
$ curl http://based.cooking/german

https://based.cooking/sauerkraut.html
```


~~If there is only one result, that page is opened.~~


## License

This website and all its content is in the public domain.
By submitting text or images or anything else to this repository,
you waive any pretense of ownership to it,
although you are welcome and recommended to give yourself credit
at the bottom of a submitted page for you adding it
(including personal or donation links).
