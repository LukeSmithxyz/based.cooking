# Based Rules

## Rationale

These rules are implemented to ensure:
- [based.cooking](https://based.cooking) stays free (libre; as in freedom),
- the repository stays neat and tidy,
- a consistent Markdown style amongst all recipes,
- consistent technical details amongst all recipes,
- appropriate tags and images representative of the recipes on which they are included,
- no bloat or soydev code is permitted,
- recipes are not condescending or verbose, and
- only authentic, traditional, high-quality food is permitted.

Make [based.cooking](https://based.cooking) based again!

## Rules

### Freedom

#### License

When you submit anything to [based.cooking](https://based.cooking), you agree to release your work under the CC0 1.0 license.
Everything in the [based.cooking](https://based.cooking) repository is licensed under the CC0 1.0 license.
Contributions licensed under any incompatible license will be rejected.

#### Requests for removal

Requests to have your work removed will be ignored.

#### Attribution

Attribution is unnecessary under the CC0 1.0 license.
However, you are welcome and recommended to give yourself credit at the bottom of a recipe you submitted, including links to your personal website and to your donation pages.
**Do not** link to social media sites.

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
- `cheesefare`: for recipes that include dairy but no milk.
- `dessert`
- `drink`
- `quick`: for recipes that can be cooked in under ~20 minutes.
- `side`: side dishes such as mash, fries, etc.
- `snack`
- `spread`
- `strict-fast`: for recipes that contain no meat or dairy.
- `vegan`
- `vegetarian`

#### Images

- Images are stored in `data/pix`.
- Each recipe can have a title image at the top and perhaps several instructional images as absolutely necessary.
- Do not add stock images you found on the internet.
Take a good picture yourself of the actual dish you prepared.
- If you see a bad or substandard image, you may submit a better one.
- Images should be in `.webp` format and with as small a file size as possible.
If you submit an image for say, `chicken-parmesan.md`, it should be added as `pix/chicken-parmesan.webp`.
- 150kB is the maximum file size for a single image.
- If you would like to add additional directional images, they should be numbered with two digits like `pix/chicken-parmesan-00.webp`, `pix/chicken-parmesan-01.webp`, etc.

### Bugmanism is banned

Vegan or vegetarian recipes are fine, but specific bugman food imitating authentic food is disallowed.

You could always substitute any ingredient for any other ingredient, or follow any instruction any way you like whilst you are preparing the dish, for example to swap meat out for a substitute.
However, do not propose these personal changes to [based.cooking](https://based.cooking).

#### Examples

- Never use a meat substitute instead of real meat.
Non-meat pretending to be meat, like soy in the shape of sausages, or mycoprotein meat substitutes, are banned.
- Tofu is only allowed when used in an authentic dish, and not as a meat substitute.

### No soyboys

No soydev code, Javascript, WebAssembly, or other bloat is permitted.

Soybeans and soy-based food are acceptable.

### No meme-tier sweet or unhealthy dishes

Only substantial dishes are allowed, no hyper-sugary desserts or junk food.

### Treat your audience as if they are intelligent

- Do not include seasonings like salt and pepper in the ingredients list.
Instead, add an instruction along the lines of "season to taste" to your recipe.
- Only include ubiquitous ingredients like salt and pepper if they are a set amount of part of the dish itself, eg. sugar baked into a cake, salt baked into a loaf of bread, or pepper stirred into a sauce.
- Keep your instructions clear and concise.
- Do not waffle on or elaborate in unnecessary ways.

### No life stories

Keep the introduction short.
Nobody cares about the 1000-page lore and backstory of your recipe's cinematic universe.

### No smoothies

Milkshakes are fine, but Luke doesn't like smoothies for some reason.

### Authentic, traditional, high-quality ingredients and dishes

Always include and prefer the name of the authentic, traditional, high-quality ingredients and dishes over the cheaper, lower-quality, mass-produced variety.

#### Examples

- "Parmesan" is the name of a generic cheese which is cheaper, mass-produced, and of lower-quality than its genuine counterpart.
The authentic, traditional cheese is called Parmigiano-Reggiano and is a protected term used to designate high-quality cheese made in a specific region of Italy.
See https://en.wikipedia.org/wiki/Parmigiano-Reggiano for more details.
This rule was instated because there used to be a parasitic prevalence and preponderance of "parmesan" on [based.cooking](https://based.cooking).
- "Parma ham" is an anglicisation of "prosciutto".
The most famous type of authentic prosciutto is probably prosciutto crudo di Parma.
See https://en.wikipedia.org/wiki/Prosciutto for more details.
