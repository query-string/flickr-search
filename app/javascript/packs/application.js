/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb

import Muuri from 'muuri'

document.addEventListener('DOMContentLoaded', () => {
  const results = document.getElementById('results')

  if (results) {
    const loading = document.getElementById('loading')
    loading.textContent = 'Loading search results...'

    window.onload = function() {
      const grid = new Muuri(results, {
        layout: {
          fillGaps: true
        }
      })

      results.classList.add('results__visible')
      loading.textContent = 'Search results'
    }
  }
})

import '../application.sass'
