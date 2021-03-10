# Based Cooking Website

[https://based.cooking](https://based.cooking)

## To-do

- get many recipes
- make and take pictures of recipes
- decide on CSS/styling, something good-looking and readable, but nothing too complicated
- search function? See below
- keep it simple

## Rules for submission

Add reciples as `.md` files to the `src/` directory.
Look at already existing `.md` files for expemlars
or see [example](example.md).

Recipe must be based, i.e. good traditional and substantial food. Nothing
ironic, meme-tier hyper-sugary, meat-substitute, etc.

### Minor rules

- Don't include salt and pepper and other uniquitous things in the ingredients list.
- If measurements are used, include metric and American measurements. Do not use decimals in American; round or use fractions.

## Images

Each recipe can have a title image at the top and perhaps
several instructional images as absolutely necessary.

Do not add stock images you found on the internet.
Take a good picture yourself of the actual dish created.
If you see a bad or substandard iamge, you may submit a better one.

Images should be in `.webp` format.
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

## curl/Search function in the future

I eventually want a command-line/curl interface to this site.
Part of this would be an implicit search function.

So suppose someone wants a recipe with chicken, I'd like
`curl based.cooking/chicken` to return articles with that title.
If there is only one result, that page is opened.

Just something to think about.
Then people could make a simple two or three character alias to get a simple text recipe.

## License

This website and all its content is in the public domain.
By submitting text or images or anything else to this repository,
you waive any pretense of ownership to it,
although you are welcome and recommended to give yourself credit
at the botton of a submitted page for you adding it
(including personal or donation links).
