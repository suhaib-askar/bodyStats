$(document).on "page:change", ->
  url = window.location.href
  $('.section-nav a').each ->
    link = $(this).attr('data-selected-links')
    if url.search(link) != -1
      $(this).addClass('selected')
    else 
      $(this).removeClass('selected')

  $('.close').click ->
    $(this).parent('.alert').fadeOut '500', ->
      $(this).remove()
    