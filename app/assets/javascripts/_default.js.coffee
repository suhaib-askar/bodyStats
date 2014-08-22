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
  
  # $.getJSON "http://www.highcharts.com/samples/data/jsonp.php?filename=aapl-c.json&callback=?", (data) ->
  #   console.log(data)
  #   $(".stock").highcharts "StockChart",
  #     rangeSelector:
  #       enabled: true
  #       inputDateFormat : '%d-%m-%Y'
  #       selected: 1
  #       inputEnabled: $(".stock").width() > 480
  #     title:
  #       text: "AAPL Stock Price"
  #     series: [
  #       name: "AAPL"
  #       data: data
  #       color: "green"
  #       marker:
  #         enabled: true
  #         radius: 3
  #       shadow: true
  #       tooltip:
  #         valueDecimals: 2
  #     ]
  #     legend:
  #       enabled: true
  #     credits:
  #       enabled: false