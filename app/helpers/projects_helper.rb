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

  def get_activities(project=@project)
    PublicActivity::Activity.includes([
      {trackable: {item: {project: :user}}}, {owner: :user}, :trackable
    ]).order("created_at desc").where(owner: project, owner_type: "Project")
  end

  def last_track_item(activities)
    activities.map(&:trackable).compact[0]
  end

  def report(project_track_items)
    sorted_tr = []
    @project.items.each do |item|
      sorted_tr[item.id] = {item_id: item.id, item_name: item.name, unit: unit(item.unit_id),start_user_data: '', end_user_data: '', data_count: 0}
      project_track_items.each do |ptr|
        if ptr.item_id == item.id
          sorted_tr[item.id][:data_count] += 1
          if sorted_tr[item.id][:start_date] && sorted_tr[item.id][:end_date]
            if sorted_tr[item.id][:start_date] > ptr.created_at
              sorted_tr[item.id][:start_user_data] = ptr.user_data
              sorted_tr[item.id][:start_date] = ptr.created_at
            elsif sorted_tr[item.id][:end_date] < ptr.created_at
              sorted_tr[item.id][:end_user_data] = ptr.user_data
              sorted_tr[item.id][:end_date] = ptr.created_at
            end
          else
            sorted_tr[item.id][:start_user_data] = ptr.user_data
            sorted_tr[item.id][:end_user_data] = ptr.user_data
            sorted_tr[item.id][:start_date] = ptr.created_at
            sorted_tr[item.id][:end_date] = ptr.created_at
          end
        end
      end
    end
    sorted_tr.compact
  end

end
