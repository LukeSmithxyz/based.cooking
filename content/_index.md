---
title: "🍲 Based Cooking 🍳"
---

## What do you want to cook?

<noscript>
<style>
.search { display: none; }
</style>
</noscript>

<div class="search">
  <input type="text" id="search" placeholder="Search...">
  <button class="clear-search">
    <svg xmlns="http://www.w3.org/2000/svg" class="ionicon" viewBox="0 0 512 512"><title>Backspace</title><path d="M135.19 390.14a28.79 28.79 0 0021.68 9.86h246.26A29 29 0 00432 371.13V140.87A29 29 0 00403.13 112H156.87a28.84 28.84 0 00-21.67 9.84v0L46.33 256l88.86 134.11z" fill="none" stroke="currentColor" stroke-linejoin="round" stroke-width="32"></path><path fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="32" d="M336.67 192.33L206.66 322.34M336.67 322.34L206.66 192.33M336.67 192.33L206.66 322.34M336.67 322.34L206.66 192.33"></path></svg>
  </button>
</div>

<script>
document.addEventListener('DOMContentLoaded', () => {
  const rec = document.querySelectorAll('#artlist li')
  const search = document.querySelector('#search')
  const clearSearch = document.querySelector('.clear-search')
  const artlist = document.getElementById('artlist')
  
  document.addEventListener('keydown', function(e) {
    // if search already focused do nothing
    if (search === document.activeElement) return;

    // if key pressed is '/'
    if (e.keyCode ===  191) {
        search.focus();

        // preventDefault so '/' is not added to search value
        e.preventDefault();
    }
  })

  search.addEventListener('input', e => {
    // grab search input value
    const searchText = e.target.value.toLowerCase()

    const hasFilter = searchText.length > 0;

    // for each recipe hide all but matched
    let matchCount = 0;
    rec.forEach(el => {
      const recipeName = el.textContent.toLowerCase()
      const isMatch = recipeName.includes(searchText)

      el.hidden = !isMatch
      el.classList.toggle('matched-recipe', isMatch && searchText.length !== 0);
      if (hasFilter && isMatch) {
        matchCount++;
      }
    })

    artlist.classList.toggle('list-searched', matchCount > 0);
  })

  clearSearch.addEventListener('click', e => {
    search.value = ''
    rec.forEach(el => {
      el.hidden = false
      el.classList.remove('matched-recipe');
    })

    artlist.classList.remove('list-searched') ;
  })
})
</script>

{{< artlist >}}

## Or Browse by Category...

{{< tagcloud >}}

## About this site

Founded to provide a simple online cookbook without ads and obese web design.
See the story of this site unfold in three videos:

- [A Demonstration of Modern Web Bloat](https://odysee.com/@Luke:7/a-demonstration-of-modern-web-bloat:f)
- [The War Against Web Bloat Continues...](https://odysee.com/@Luke:7/the-war-against-web-bloat-continues...:a)
- [SoyDevs DESTROYED Epic Style by Based Cooking!](https://odysee.com/@Luke:7/soydevs-destroyed-epic-style-by-based:6)

## It's easy to contribute!

New recipes can be submitted [on Github](https://github.com/lukesmithxyz/based.cooking).
We are funded by you only, not 20MB of ads or privacy-violating trackers per page.

{{< crypto >}}
