#= require active_admin/base
#= require select2

$(document).ready ->
  $("select.select2Able").select2 placeholder: "Select..."

  $(".button.has_many_add").bind "click", ->
    setTimeout (->
      $("select.select2Able").select2 placeholder: "Select..."
    ), 100
