---
title: "🍲 Freies Kochen 🍳"
description: 'Die am schnellsten ladene Rezeptwebseite. Auschließlich kochen und keine Werbung.'
layout: single
---
# Diese Webseite gibt es auch in: <a href="https://based.cooking/en/">🇬🇧/🇺🇸</a>
## Was möchtest du kochen?
# Diese Webseite ist wird noch aktiv übersetzt. Die meisten Rezepte sind noch auf Englich.
<div class="search js-only">
  <input type="text" id="search" placeholder="Suche nach ALLEN Rezepten...">
  <button id="clear-search">
    <svg xmlns="http://www.w3.org/2000/svg" class="ionicon" viewBox="0 0 512 512"><title>Backspace</title><path d="M135.19 390.14a28.79 28.79 0 0021.68 9.86h246.26A29 29 0 00432 371.13V140.87A29 29 0 00403.13 112H156.87a28.84 28.84 0 00-21.67 9.84v0L46.33 256l88.86 134.11z" fill="none" stroke="currentColor" stroke-linejoin="round" stroke-width="32"></path><path fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="32" d="M336.67 192.33L206.66 322.34M336.67 322.34L206.66 192.33M336.67 192.33L206.66 322.34M336.67 322.34L206.66 192.33"></path></svg>
  </button>
</div>

<script>
// @license magnet:?xt=urn:btih:5ac446d35272cc2e4e85e4325b146d0b7ca8f50c&dn=unlicense.txt Unlicense

document.addEventListener("DOMContentLoaded", () => {
  for (e of document.getElementsByClassName("js-only")) {
    e.classList.remove("js-only");
  }

  const recipes = document.querySelectorAll("#artlist li");
  const search = document.getElementById("search");
  const oldheading = document.getElementById("newest-recipes");
  const clearSearch = document.getElementById("clear-search");
  const artlist = document.getElementById("artlist");

  search.addEventListener("input", () => {
    // grab search input value
    const searchText = search.value.toLowerCase().trim().normalize('NFD').replace(/\p{Diacritic}/gu, "");
    const searchTerms = searchText.split(" ");
    const hasFilter = searchText.length > 0;

    artlist.classList.toggle("list-searched", hasFilter);
    oldheading.classList.toggle("hidden", hasFilter);

    // for each recipe hide all but matched
    recipes.forEach(recipe => {
      const searchString = `${recipe.textContent} ${recipe.dataset.tags}`.toLowerCase().normalize('NFD').replace(/\p{Diacritic}/gu, "");
      const isMatch = searchTerms.every(term => searchString.includes(term));

      recipe.hidden = !isMatch;
      recipe.classList.toggle("matched-recipe", hasFilter && isMatch);
    })
  })

  clearSearch.addEventListener("click", () => {
    search.value = "";
    recipes.forEach(recipe => {
      recipe.hidden = false;
      recipe.classList.remove("matched-recipe");
    })

    artlist.classList.remove("list-searched");
    oldheading.classList.remove("hidden");
  })
})
// @license-end
</script>

## Neue Rezepte

{{< artlist >}}

## Oder suche via Kategorien...

{{< tagcloud >}}

## Über diese Webseite

Erstellt um ein einfaches online Kochbuch ohne Werbung und schlanken Design darzustellen 
Siehen Sie in 3 Vidoes die Historie, weshalb wir diese Webseite begonnen haben.
Diese Videos sind noch in Englisch.

- [Ein Demonstration von dem Modern aufgebläten Web](https://odysee.com/@Luke:7/a-demonstration-of-modern-web-bloat:f)
- [Der Krieg gegen das augebläten Web geht in die Nächste Runde...](https://odysee.com/@Luke:7/the-war-against-web-bloat-continues...:a)
- [SoyDevs wurden auf epischer Weise von Based Cooking ZERSTÖRT!](https://odysee.com/@Luke:7/soydevs-destroyed-epic-style-by-based:6)

## Die Teilnahme ist einfach!

Neu Rezepte können [auf Github](https://github.com/lukesmithxyz/based.cooking) Vorgeschlagen werden.
Wir exestiern nur wegen euch, hier gibt es keine 20MB an Werbung oder Privatsphäre igronierenden Tracker auf jeder Unterseite.
{{< crypto >}}
