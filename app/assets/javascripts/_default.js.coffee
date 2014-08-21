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
  $('.hide-column').click (e) ->
    e.preventDefault()
    $('.column_3').hide()
  # if gon && gon.no_header_footer
  #   $('.header').hide()
  #   $('.footer').hide()
  #   $('body').attr("data-tuktuk", "boxes")