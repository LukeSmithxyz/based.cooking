"use strict";
/*
    Offline Website, functions for Service Worker
    Copyright (C) 2021  Filip Strajnar
    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.
    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.
    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/
/*
    ====== IMPORTANT ======
    Make sure this Service worker is at the root of your application!!!
    Service worker installed at /subdirectory will only handle anything under it
    (for example: /subdirectory/asset1, /subdirectory/asset2)
    it will ignore / (root) and /index.html because it's above /subdirectory !
    ====== IMPORTANT ======
*/
const cacheName = "based_cooking";
function CacheResourcesOnInstallation(array_of_resources) {
    // array_of_resources should contain strings of paths you wish to cache ( Example: /index.html )
    self.addEventListener('install', function (event) {
        // This event happens when Service worker is being installed
        event.waitUntil(caches.open(cacheName).then(function (chosen_cache) {
            // Opens cache (you can have multiple caches with different names)
            return chosen_cache.addAll(array_of_resources); // Adds all the resources to cache
        }));
    });
}
function ActivateCacheFirst() {
    // ** Cache First (Cache Falling Back to Network) **
    // Calling this function will activate cache-first strategy of caching assets.
    // This means that when user makes a request, service worker will first check
    // cache (storage on disk), if asset is located there it'll return it without
    // making an HTTP(s) request. If asset isn't found in cache, it forwards the
    // request like it would normally do.
    self.addEventListener('fetch', (fetch_event) => {
        // On fetch (asset request from browser)
        fetch_event.respondWith((async () => {
            const cache_response = await caches.match(fetch_event.request);
            if (cache_response)
                return cache_response;
            // if cache responded with not null (meaning it has the asset), return the asset
            const response = await fetch(fetch_event.request);
            // if cache didn't find the resource, the return hasn't happened yet, so it continues
            // by making a fetch (web) request
            const cache = await caches.open(cacheName);
            // opens the cache, getting ready to store the new asset
            cache.put(fetch_event.request, response.clone());
            // Actually stores the asset in the cache
            return response;
            // And returns to the browser.
        })());
    });
}
function ActivateNetworkFirst() {
    // ** Network First (Network Falling Back to Cache) **
    // Calling this function will activate network-first strategy. Whenever user makes a request,
    // browser will try to make a web request. If web request was successfull, it will store the
    // asset to the cache and return it to browser. If web request fails, it will look at the cache
    // which has the latest asset (it last obtained), and return it to the user.
    self.addEventListener('fetch', (fetch_event) => {
        // On fetch event
        fetch_event.respondWith((async () => {
            try {
                // Try to make a normal web request
                const response = await fetch(fetch_event.request);
                if (response.ok) {
                    const cache = await caches.open(cacheName);
                    cache.put(fetch_event.request, response.clone());
                    return response;
                }
            }
            catch {
                // If web request failed, fall back to cache
                console.log(`Asset unreachable, falling back to cache for: ${fetch_event.request.url}`);
                const cache_response = await caches.match(fetch_event.request);
                if (cache_response)
                    return cache_response;
            }
        })());
    });
}
async function ClearAllCache() {
    const all_cache_names = await caches.keys();
    all_cache_names.forEach(cache_name => {
        caches.delete(cache_name);
    });
}
ActivateNetworkFirst(); // Safe choice. In case the user has no internet access,
// they will still see last loaded resource,

// Changing to ActivateCacheFirst() will completely remove the need to
// make HTTP requests, but because of that updates won't be seen (user would
// have to manually clear cache so new resources come in, which can be implemented
// with just click of a button)