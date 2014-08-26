module ProjectsHelper
  
  def render_chart(project)
    LazyHighCharts::HighChart.new('stock') do |f|
      f.rangeSelector(selected: 1, inputEnabled: true,
                      buttons: [{type: 'day',count: 1,text: '1D'}, 
                                {type: 'week',count: 1,text: '1W'}, 
                                {type: 'month',count: 1,text: '1M'},  
                                {type: 'month',count: 6,text: '6M'}, 
                                {type: 'year',count: 1,text: '1Y'}, 
                                {type: 'all',count: 1,text: 'All'}])
      project.items.includes(:track_items).each do |i|  
        data = i.track_items.map {|tr| [tr.created_at.to_i * 1000, tr.user_data] }
        visible = i != project.items[0] ? false : true
        f.series(name: i.name, 
                  data: data,
                  tooltip: { valueDecimals: 2},
                  marker: { enabled: true, radius: 3},
                  visible: visible,
                  shadow: true)
      end
      f.legend(enabled: true)
      f.plotOptions(spline: { turboThreshold: 2000}, line: { dataLabels: { enabled: true }})
      f.credits(enabled: false)
    end
  end

  def get_activities(project)
    PublicActivity::Activity.includes([
      {trackable: {item: {project: :user}}}, {owner: :user}, :trackable
    ]).order("created_at desc").where(owner: project, owner_type: "Project")
  end

  def last_track_item(activities)
    activities.map(&:trackable).compact[0]
  end

end
