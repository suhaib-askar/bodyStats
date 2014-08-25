$(".my-stock-chart").html "<%= escape_javascript(render('projects/stock_chart')) %>"
$(".latest-activity").html "<%= escape_javascript(render('projects/latest_activity')) %>"
$(".activities").html "<%= escape_javascript(render('projects/activities')) %>"