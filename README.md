# Based Cooking Website

[https://based.cooking](https://based.cooking)

## To-do

- get many recipes
- make and take pictures of recipes
- decide on CSS/styling, something good-looking and readable, but nothing too complicated
- search function? See below
- keep it simple

## Rules for submission

- Recipes should be `.md` files in the `src/` directory.  Look at already
  existing `.md` files for examples or see [example](example.md).
- File names should be the name of the dish with words separated by hypens
  (`-`). Not underscores, and definitely not spaces.
- Recipe must be based, i.e. good traditional and substantial food. Nothing
  ironic, meme-tier hyper-sugary, meat-substitute, etc.
- **ADD YOUR RECIPE TO THE LIST ON `index.md` OR NO ONE WILL EVER SEE IT.**
- Don't include salt and pepper and other ubiquitous things in the ingredients
  list.

**If you fail to do these things, I will close your submission and you will have to resubmit. I am tired of having to fix more than 50% of submissions.**

### Images

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

The front page, for now, will just be a list of recipes
and when adding a `.md` page, please manually add a link to it in the list.
As more articles are added, the site will be reorganized, categorized
or will implement server-side scripting or searches.
This is not necessary yet though.

I don't really want images of recipes on the mainpage yet.
I'll think about how best to do it to minimize bandwidth if possible.

This site is generated with [Roman Zolotarev](https://www.romanzolotarev.com/)'s
[ssg5](https://www.romanzolotarev.com/ssg.html) which is also included in this
repo for replicability.

## curl/Search function

So suppose someone wants a recipe with chicken, to return articles with that title:
```bash
$ curl based.cooking/search/chicken

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
~~If there is only one result, that page is opened.~~


## License

This website and all its content is in the public domain.
By submitting text or images or anything else to this repository,
you waive any pretense of ownership to it,
although you are welcome and recommended to give yourself credit
at the bottom of a submitted page for you adding it
(including personal or donation links).
