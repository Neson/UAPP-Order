# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

productsIsotope = ->
  window.$container = $(".products.items").isotope(
    itemSelector: ".product.item"
    layoutMode: "masonry"
    getSortData:
      name: ".name"
      price: ".price parseFloat"
      purchases: ".purchases parseInt"
      updateTime: "[data-updatedAt] parseInt"
      # weight: (itemElem) ->
      #   weight = $(itemElem).find(".weight").text()
      #   parseFloat weight.replace(/[\(\)]/g, "")
  )
  # filter functions
  filterFns =

    buy: ->
      number = $(this).find("input").val()
      parseInt(number) > 0


  # bind filter button click
  $("#filters").on "click", "a", ->
    filterValue = $(this).attr("data-filter")
    filterValue = filterFns[filterValue] or filterValue
    $container.isotope filter: filterValue
    setTimeout ->
      $('#tags.select').val('')
      $('#tags.select').select2()
    , 100

  $(".filter-toggle").bind "click", ->
    filterValue = $(this).attr("data-filter")
    # $container.isotope filter: filterValue
    # console.log filterValue
    a = $('#tags.select').val()
    a.push(filterValue) if a
    setTimeout ->
      $('#tags.select').val a or [filterValue]
      $('#tags.select').change()
      $('#tags.select').select2()
    , 100

  $(".filter-shopping-cart").bind "click", ->
    $container.isotope filter: '.active'
    setTimeout ->
      $('#tags select').val(['.active'])
      $('#tags select').select2()
    , 100

  $('#tags.select').change ->
    # filterValue = $('#tags.select').val()?.join(', ')
    filterValue = $('#tags.select').val()?.join('')
    $container.isotope filter: filterValue

  # bind sort button click
  $("#sorts").on "click", "a", ->
    sortByValue = $(this).attr("data-sort-by")
    $container.isotope
      sortBy: sortByValue
      sortAscending: false if sortByValue = 'purchases' or sortByValue = updateTime

  # change is-checked class on buttons
  $(".menu.controls").each (i, controls) ->
    $controls = $(controls)
    $controls.on "click", "a", ->
      $controls.find(".active").removeClass "active"
      $(this).addClass "active"

$ ->
  $('select.select2').select2()
  # init Isotope
  productsIsotope()

window.refTope = ->
  productsIsotope()
  setTimeout refTope, 1000
refTope()
