$('#star-input').keypress (e) ->
  if e.keycode != 8 and (parseInt($(this).val()) > 5 or parseInt($(this).val()) < 1)
    e.preventDefault()