class ProjectsController < ApplicationController
  include ApplicationHelper
  before_action :authenticate_user!
  before_action :set_project, only: [ :show, :edit, :update, :destroy ]
  before_action :no_header_footer!, only: [ :show ]
  before_action :units, only: [ :show ]
  
  def new
    @project = Project.new
  end
  
  def show
    # eagre loading, Nested
    
    @activities = PublicActivity::Activity.includes([{trackable: {item: {project: :user}}}, {owner: :user}, :trackable]).order("created_at desc").where(owner: @project, owner_type: "Project")
    @last = @activities.map(&:trackable).compact[0]
    # "DAYOFMONTH(created_at) = ? or MONTH(created_at) = ?"
    # data = Net::HTTP.get(URI.parse("http://www.highcharts.com/samples/data/jsonp.php?filename=aapl-c.json&callback=?"))
  
    @stock = LazyHighCharts::HighChart.new('stock') do |f|
      f.rangeSelector(selected: 1, inputEnabled: true,
                      buttons: [{type: 'day',count: 1,text: '1D'}, 
                                {type: 'week',count: 1,text: '1W'}, 
                                {type: 'month',count: 1,text: '1M'},  
                                {type: 'month',count: 6,text: '6M'}, 
                                {type: 'year',count: 1,text: '1Y'}, 
                                {type: 'all',count: 1,text: 'All'}])
      #f.title( text: fl(@project.name))
      #Micropost.includes(:user).from_users_followed_by(self)
      @project.items.includes(:track_items).each do |i|  
        data = i.track_items.map {|tr| [tr.created_at.to_i * 1000, tr.user_data] }
        visible = i != @project.items[0] ? false : true
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
  
  def create
    @project = current_user.projects.build(project_params)
    respond_to do |format|
      if @project.save
        format.html { redirect_to project_items_url(@project) }
      else
        format.html { render :new }
      end
    end
  end

  private 

    def set_project
      @project = current_user.projects.find(params[:id])
    end

    def project_params
      params.require(:project).permit(:name, :description)
    end
    
    def units
      @units = Unit.all.map { |u|  { u.id => {full_en: u.full_en, short_en: u.short_en, full_ru: u.full_ru, short_ru: u.short_ru} } } 
    end
end
