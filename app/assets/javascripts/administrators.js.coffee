$ ->
  if $("#new_administrator").length > 0
    clean_errors()
    
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
  console.log(object)
  object.parent().removeClass("field_with_errors")
