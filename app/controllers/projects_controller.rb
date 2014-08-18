class ProjectsController < ApplicationController
  include ApplicationHelper
  before_action :authenticate_user!
  before_action :set_project, only: [ :show, :edit, :update, :destroy ]

  def new
    @project = Project.new
  end
  
  def show
    # if request.path != project_path(@project)
    #   redirect_to @project, status: :moved_permanently
    # end
    # @chart = LazyHighCharts::HighChart.new('graph') do |f|
    #   f.title(:text => "Population vs GDP For 5 Big Countries [2009]")
    #   f.xAxis(:categories => ["United States", "Japan", "China", "Germany", "France"])
    #   f.series(:name => "GDP in Billions", :yAxis => 0, :data => [14119, 5068, 4985, 3339, 2656])
    #   f.series(:name => "Population in Millions", :yAxis => 1, :data => [310, 127, 1340, 81, 65])

    #   f.yAxis [
    #     {:title => {:text => "GDP in Billions", :margin => 70} },
    #     {:title => {:text => "Population in Millions"}, :opposite => true},
    #   ]

    #   f.legend(:align => 'right', :verticalAlign => 'top', :y => 75, :x => -50, :layout => 'vertical',)
    #   f.chart({:defaultSeriesType=>"column"})
    # end
    @chart = LazyHighCharts::HighChart.new('graph') do |f|
      f.title(text: fl(@project.name))
      f.subtitle(text: @project.description)
      @project.items.each do |i|
        f.series(name: i.name, data: i.track_items.map { |ti| ti.user_data }) 
      end
      f.xAxis(categories: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'])
      f.yAxis({ 
        title: { text: "Performance" } 
        })
      f.plotOptions({
          line: {
            dataLabels: { enabled: true },
            enableMouseTracking: true
          }
        })
      f.chart({ defaultSeriesType: "line" })
    end

    # @chart = LazyHighCharts::HighChart.new('graph') do |f|
    #   f.data({csv: "csv"})
    #   f.title(text: "lala")
    #   f.subtitle(text: "la")
    #   f.xAxis({
    #     type: 'datetime',
    #     tickInterval: 7*24*3600*1000,
    #     tickWidth: 0,
    #     gridLineWidth: 1,
    #     labels: { align: 'left', x: 3, y: -3 }
    #     })
    #   f.yAxis [{
    #       title: { text: nil },
    #       labels: {
    #         align: 'left',
    #         x: 3,
    #         y: 16,
    #         format: '{value:.,0f}'
    #       },
    #       showFirstLabel: false  
    #     }, 
    #     {
    #       linkedTo: 0,
    #       gridLineWidth: 0,
    #       opposite: true,
    #       title: { text: nil },
    #       labels: {
    #         align: 'right',
    #         x: -3,
    #         y: 16,
    #         format: '{value:.,0f}'
    #       },
    #       showFirstLabel: false
    #     }]
    #     f.legend({
    #       align: 'left',
    #       verticalAlign: 'top',
    #       y: 20,
    #       floating: true,
    #       borderWidth: 0  
    #     })
    #     f.tooltip({
    #       shared: true,
    #       crosshairs: true
    #     })
    #     f.plotOptions({
    #       series: {
    #         cursor: 'pointer',
    #         marker: { lineWidth: 1 }
    #       }  
    #     })
    #     f.series({
    #       name: 'All visits',
    #       lineWidth: 4,
    #       marker: { radius: 4 }  
    #     })
    # end
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

end
