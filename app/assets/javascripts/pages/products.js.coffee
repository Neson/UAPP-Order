# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $('select.select2').select2()
  # init Isotope
  $container = $(".products").isotope(
    itemSelector: ".product"
    layoutMode: "masonry"
    getSortData:
      name: ".name"
      price: ".price"
      purchases: ".purchases"
      updateTime: "[data-updatedAt]"
      # weight: (itemElem) ->
      #   weight = $(itemElem).find(".weight").text()
      #   parseFloat weight.replace(/[\(\)]/g, "")
  )

  # filter functions
  filterFns =

    # show if number is greater than 50
    numberGreaterThan50: ->
      number = $(this).find(".number").text()
      parseInt(number, 10) > 50

    # show if name ends with -ium
    ium: ->
      name = $(this).find(".name").text()
      name.match /ium$/

  # bind filter button click
  $("#filters").on "click", "button", ->
    filterValue = $(this).attr("data-filter")
    filterValue = filterFns[filterValue] or filterValue
    $container.isotope filter: filterValue

  $(".filter-toggle").bind "click", ->
    filterValue = $(this).attr("data-filter")
    # $container.isotope filter: filterValue
    # console.log filterValue
    a = $('#tags.select').val()
    a.push(filterValue) if a
    $('#tags.select').val a or [filterValue]
    $('#tags.select').change()
    $('#tags.select').select2()

  $('#tags.select').change ->
    # filterValue = $('#tags.select').val()?.join(', ')
    filterValue = $('#tags.select').val()?.join('')
    $container.isotope filter: filterValue

  # bind sort button click
  $("#sorts").on "click", "a", ->
    sortByValue = $(this).attr("data-sort-by")
    $container.isotope sortBy: sortByValue

  # change is-checked class on buttons
  $(".menu.controls").each (i, controls) ->
    $controls = $(controls)
    $controls.on "click", "a", ->
      $controls.find(".active").removeClass "active"
      $(this).addClass "active"