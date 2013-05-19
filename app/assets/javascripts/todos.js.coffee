$(document).on "keypress", "[data-behavior~=submit_on_enter]", (e) ->
  if e.keyCode is 13
    $(@).closest("form").submit() if $(@).val().length
    e.preventDefault()

$(document).on "click", "[data-behavior~=submit_on_check]", ->
  $(@).closest("form").submit()