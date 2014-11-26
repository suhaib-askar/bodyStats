$(".my-stock-chart").html "<%= escape_javascript(render('projects/stock_chart')) %>"
$(".latest-activity").html "<%= escape_javascript(render('projects/latest_activity')) %>"
$(".activities").html "<%= escape_javascript(render('projects/activities')) %>"
$(".menu-links").html "<%= escape_javascript(render('projects/menu_links')) %>"
$(".more-info").html "<%= escape_javascript(render('projects/more_info')) %>"
$(".more-info").masonry 'reloadItems'
$(".more-info").masonry()

