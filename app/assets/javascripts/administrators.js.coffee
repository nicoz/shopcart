$ ->
  if $("#new_administrator").length > 0
    clean_errors()
  
  $("div.pagination ul").addClass('pagination')
  
  $('.previous_page > a').html("Previo")
  $('.next_page > a').html("Proximo")
  
clean_errors = ->
  $("form").on("change","input", () -> 
    remove_parent_class($(this))
  )
  $("form").on("keypress","input", () -> 
    remove_parent_class($(this))
  )
  $("form").on("paste","input", () -> 
    remove_parent_class($(this))
  )
  
    
remove_parent_class = (object) ->
  object.parent().removeClass("field_with_errors")
