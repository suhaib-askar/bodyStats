$(".more-info").html("<%= escape_javascript(render('more_info')) %>")
$(".more-info").masonry 'reloadItems'
$(".more-info").masonry()
