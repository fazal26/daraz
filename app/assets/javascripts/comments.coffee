reply = (id) ->
  document.getElementById('comment_body').placeholder = 'Reply: '
  document.getElementById('parent_value').value = id
  return