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
  
  # height chart
  $('.my-stock-chart').height($(document).height() / 2)
  $(window).resize ->
    $('.my-stock-chart').height($(document).height() / 2)   

  # cookie
  if $.cookie('aside-left')
    $('.aside-left').addClass("asside-hide")
    $('.b-left').removeClass('glyphicon-chevron-left').addClass('glyphicon-chevron-right')
    
  if $.cookie('aside-right')
    $('.aside-right').addClass("asside-hide")
    $('.b-right').removeClass('glyphicon-chevron-right').addClass('glyphicon-chevron-left')

  $('.b-hide').off().on 'click', (e) ->
    e.preventDefault()
    if $(this).hasClass('b-left')
      $('.aside-left').toggleClass("asside-hide")
      if $('.aside-left').hasClass('asside-hide')
        $(this).removeClass('glyphicon-chevron-left').addClass('glyphicon-chevron-right')
        $.cookie('aside-left', false)
      else
        $(this).removeClass('glyphicon-chevron-right').addClass('glyphicon-chevron-left')
        $.cookie('aside-left', null)
    else
      $('.aside-right').toggleClass("asside-hide")
      if $('.aside-right').hasClass('asside-hide')
        $(this).removeClass('glyphicon-chevron-right').addClass('glyphicon-chevron-left')
        $.cookie('aside-right', false)
      else
        $(this).removeClass('glyphicon-chevron-left').addClass('glyphicon-chevron-right')
        $.cookie('aside-right', null)
    $(window).trigger 'resize'
    $('.more-info').masonry()
    

  # toggle Chart DataLabels
  enableDataLabels = false
  $(".toggle-labels").click (e) ->
    e.preventDefault()
    c = chart_project_stock.series
    $.each c, (i,v) ->
      v.update dataLabels:
        enabled: enableDataLabels 
    enableDataLabels = !enableDataLabels

  # Toggle point markers
  enableMarkers = false;
  $('.toggle-markers').click (e) ->
    e.preventDefault()
    c = chart_project_stock.series
    $.each c, (i,v) ->
      v.update marker:
        enabled: enableMarkers
    enableMarkers = !enableMarkers;

  # Set type
  $.each [
    "line", "column", "spline", "area", "areaspline", "pie"
  ], (i, type) ->
    $(".toggle-" + type).click (e) ->
      e.preventDefault()
      c = chart_project_stock.series
      $.each c, (i,v) ->
        v.update type: type


# # jquery ui upload modal
#   dialog = $(".upload").dialog(
#     autoOpen: false
#     height: 300
#     width: 350
#     modal: false
#     buttons:
#       "Upload": ->
#         dialog.find( "form" ).submit()
#         dialog.dialog "close"
#   )

#   $(".project-image").click -> 
#     dialog.dialog "open"
  
  $('.project-image-block').on 'change', '#project_image', ->
    $(".project-image-form").trigger 'submit'

  $('.project-image-block').on 'click', '.project-image', ->
    $('#project_image').trigger 'click'

  $('.more-info').masonry
    itemSelector: '.mas',
    columnWidth: 31

  $(".details-toggle").off().click ->
    $(".info-hide-block").toggleClass("asside-hide")
    $(".detail-form").toggleClass("asside-hide")
    $(window).trigger 'resize'
    $('.more-info').masonry()
  $(".chart-toggle").off().click ->
    $(".my-stock-chart").toggleClass("asside-hide")
    $(window).trigger 'resize'
    $('.more-info').masonry()

  $(".project").hoverOver
    aniTypeIn: "flybottom"
    aniTypeOut: "flybottom"
    aniDurationIn: 600
    aniDurationOut: 900
    contentShowHeight: 65

  $(".hover-content-box").click ->
    window.location.href = $(this).parents("#project").data("url")

  notify = $('.custom-header-tuk').height() || $('.custom-header').height() + 30 
  $('#frontend_notification').height(notify) 
  $('.message').css("line-height", notify + "px")