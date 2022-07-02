# Based Cooking Website

[https://based.cooking](https://based.cooking)

This is a simple cooking website where users can submit recipes here for credit.
There are no ads, trackers or cookies (unless recipes thereof).

This site is compiled and organized with Hugo, using [this very simple theme](https://github.com/lukesmithxyz/lugo).

## Ways to contribute

- By adding a recipe.
- Make a recipe and take a nice picture of it if no nice picture already
  exists. Submitted images should be small `.webp` files ideally less than 100K
  or so.
- Fix errors in recipes or add minor improvements.

## Rules for submission

- Model submission files after [example.md](example.md). Put them in `content/`.
- Recipes should start with a title, with a single `#`, *on the first line*. No
  empty line at the top, no trailing line at the end. The file needs to be `\n`
  terminated in unix-fashion (if you're on linux you don't need to care, it
  should be automatic).
- File names should be the name of the dish with words separated by hyphens
  (`-`). Not underscores, and definitely not spaces.
- Recipe must be based, i.e. good traditional and substantial food. Nothing
  ironic, meme-tier hyper-sugary, meat-substitute, etc.
- Don't include salt and pepper and other ubiquitous things in the ingredients
  list.

**If you fail to do these things, I will close your submission and you will have to resubmit. I am tired of having to fix more than 50% of submissions.**

You may include a json file with your personal links/donation addresses in
`data/authors/your-name.json`. See mine (`data/authors/luke-smith.json`) for a
model. You can include: `website`, `donate` (general donation link), `email` or
crypto addresses as `btc`, `xmr` and `eth`.

### Tags

Remember to add tags to your recipe, but try to use tags already used by other recipes.

If your recipe contains no meat or dairy, include the `fasting` tag.
If it includes dairy but no milk, incude the `cheesefare` tag.

### Images

Images are stored in `/pix`.

Each recipe can have a title image at the top and perhaps several instructional
images as absolutely necessary.

Do not add stock images you found on the internet. Take a good picture yourself
of the actual dish created. If you see a bad or substandard image, you may
submit a better one.

Images should be in `.webp` format and with as small file size as possible. If
you submit an image for say, `chicken-parmesan.md`, it should be added as
`pix/chicken-parmesan.webp`.

If you would like to add additional directional images,
they should be numbered with two digits like: `pix/chicken-parmesan-01.webp`, etc.

Note also that images should have links beginning with a slash in this use
case, i.e. `/pix/...`.

## License

This website and all its content is in the public domain.
By submitting text or images or anything else to this repository,
you waive any pretense of ownership to it,
although you are welcome and recommended to give yourself credit
at the bottom of a submitted page for you adding it
(including personal or donation links).
