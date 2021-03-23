# Based Rules

## Rationale

These rules are implemented to ensure:
- the repository stays neat and tidy,
- a consistent Markdown style amongst all recipes,
- consistent technical details amongst all recipes,
- appropriate tags and images representative of the recipes on which they are included,
- recipes are not condescending or verbose, and
- only authentic, traditional, high-quality food.

Make [based.cooking](https://based.cooking) based again!


## Rules

### Recipe format

Model submission files after [example.md](example.md), then put them in `src/`.

### Markdown style

Recipes should start with a title, with a single `#` *on the first line*.

### Technical details

#### File format

- Recipes should start with no empty line at the top and end with no trailing lines.
- There should be no trailing whitespace.
- The file needs to be `\n` terminated in Unix-like fashion (if you're using a Unix-like system, it should be automatic).
- Encode files in UTF-8.

#### File name

- File names should be the name of the dish with words separated by hyphens (`-`), not underscores, and definitely not spaces.

#### Tags

- Recipes should end with a list of relevant tags.
The syntax is:

```md
;tags: tag1 tag2 tag3
```

- The tag line should be a single line, at the end of the markdown file, preceded by a blank line.
- Add between a few (1-4) tags.
- **Prioritize existing tags**.
- As a general guideline, add the country from which the recipe originates if the recipe is representative of said country, using the adjective form (eg. *mexican*, *italian*, etc).
- Tag the main ingredient if it's something slightly special.


##### List of special, categorical tags to use if relevant

- `basic`: for basic recipes that aren't meant to be standalone but are supposed
  to be incorporated in another recipe.
- `breakfast`
- `dessert`
- `drink`
- `quick`: for recipes that can be cooked in under ~20 minutes.
- `side`: side dishes such as mash, fries, etc.
- `snack`
- `spread`

#### Images

- Images are stored in `data/pix`.
- Each recipe can have a title image at the top and perhaps several instructional images as absolutely necessary.
- Do not add stock images you found on the internet.
Take a good picture yourself of the actual dish you prepared.
- If you see a bad or substandard image, you may submit a better one.
- Images should be in `.webp` format and with as small a file size as possible.
If you submit an image for say, `chicken-parmesan.md`, it should be added as `pix/chicken-parmesan.webp`.
- If you would like to add additional directional images, they should be numbered with two digits like `pix/chicken-parmesan-00.webp`, `pix/chicken-parmesan-01.webp`, etc.

### Bugmanism is banned

Vegan or vegetarian recipes are fine, but specific bugman food imitating authentic food is disallowed.

#### Examples

- soy sausages
- tofu
- mycoprotein meat substitutes

### No soyboys

Soy is banned. For the lulz.

### No meme-tier sweet or unhealthy dishes

Only substantial dishes are allowed, no hyper-sugary desserts or junk food.

### Treat your audiance as if they are intelligent

- Do not include ubiquitous ingredients like salt and pepper in the ingredients list.
- Keep your instructions clear and concise.
- Do not waffle on or elaborate in unnecessary ways.

### No life stories

Keep the introduction short.
Nobody cares about the 1000-page lore and backstory of your recipe's cinematic universe.

### No smoothies

Luke says so.

### Autuentic, traditional, high-quality ingredients and dishes

Always include and prefer the name of the authentic, traditional, high-quality ingredients and dishes over the cheaper, lower-quality, mass-produced variety.

#### Examples

- "Parmesan" is the name of a generic cheese which is cheaper, mass-produced, and of lower-quality than its genuine counterpart.
The authentic, traditional cheese is called Parmigiano-Reggiano and is a protected term used to designate high-quality cheese made in a specific region of Italy.
See https://en.wikipedia.org/wiki/Parmigiano-Reggiano for more details.
This rule was instated because there used to be a parasitic prevalence and preponderance of "parmesan" on [based.cooking](https://based.cooking).
- "Parma ham" is an anglicisation of "prosciutto".
The most famous type of authentic prosciutto is probably prosciutto crudo di Parma.
See https://en.wikipedia.org/wiki/Prosciutto for more details.
