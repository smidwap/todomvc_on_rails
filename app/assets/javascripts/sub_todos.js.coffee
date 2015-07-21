# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on "dblclick", "[data-behavior~=sub_todo_title]", ->
  $(@).closest("li")
    .addClass("editing")
    .siblings()
    .removeClass("editing")

  $(@).closest("li").find("[data-behavior~=todo_title_input]").focus()
