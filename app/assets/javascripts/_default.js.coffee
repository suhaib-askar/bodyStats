$(document).on "page:change", ->
  # анимация загрузки страницы
  TukTuk.Modal.loading();
  setTimeout( TukTuk.Modal.hide, 1000);

  # меню, выбор активного пункта
  url = window.location.href
  $('.section-nav a').each ->
    link = $(this).attr('data-selected-links')
    if url.search(link) != -1
      $(this).addClass('selected')
    else 
      $(this).removeClass('selected')

  # закрытие формы с ошибками
  $('.close').click ->
    $(this).parent('.alert').fadeOut '500', ->
      $(this).remove()
  # cookie
  if $.cookie('aside-left')
    $('.aside-left').addClass("asside-hide")
    $('.b-left').removeClass('glyphicon-chevron-left').addClass('glyphicon-chevron-right')
    
  if $.cookie('aside-right')
    $('.aside-right').addClass("asside-hide")
    $('.b-right').removeClass('glyphicon-chevron-right').addClass('glyphicon-chevron-left')

  # cтартовая ширина
  if $.cookie('crt-wdt')
    start_w = $.cookie('crt-wdt')
  else
    start_w = $('section > article').width()

  start_crt = start_w - 20
  $('#project_stock').width(start_crt) # установка ширины чарта при загрузке стр
  $(window).trigger 'resize'
  # метод который меняет динамически ширину
  res = (start_w, start_crt) ->
    current_w = $('section > article').width()
    if start_w < current_w
      wid = start_crt + (current_w - start_w)
    else 
      wid = start_crt - (start_w - current_w)
    $('#project_stock').width(wid)

  # при изменении размера окна, меняем ширину чарта
  $(window).resize ->
    res start_w, start_crt
  
  # клик на кнопки скрыть левый правый блоки
  $('.b-hide').off().on 'click', (e) ->
    if $(this).hasClass('b-left')
      $('.aside-left').toggleClass("asside-hide")
      if $('aside#menu').hasClass('active')
        TukTuk.Box.hide()
      if $('.aside-left').hasClass('asside-hide')
        $.cookie('aside-left', false)
      else
        $.cookie('aside-left', null)
    else
      $('.aside-right').toggleClass("asside-hide")
      if $('.aside-right').hasClass('asside-hide')
        $.cookie('aside-right', false)
      else
        $.cookie('aside-right', null)
    $(this).toggleClass ->
      if $(this).hasClass('glyphicon-chevron-left')
        $(this).removeClass('glyphicon-chevron-left')
        'glyphicon-chevron-right'
      else
        $(this).removeClass('glyphicon-chevron-right')
        'glyphicon-chevron-left'
    [1..8].forEach -> 
      $(window).trigger 'resize'
    $.cookie('crt-wdt', $('section > article').width())
    e.preventDefault()

  
  
  

  
  
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