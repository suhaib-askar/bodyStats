class ProjectsController < ApplicationController
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
      f.title(text: "Monthly Average Temperature")
      f.subtitle(text: "Source: WorldClimate.com")
       f.series(name: 'Tokyo', data: [7.0, 6.9, 9.5, 14.5, 18.4, 21.5, 25.2, 26.5, 23.3, 18.3, 13.9, 9.6])
      f.series(name: 'London', data: [3.9, 4.2, 5.7, 8.5, 11.9, 15.2, 17.0, 16.6, 14.2, 10.3, 6.6, 4.8])
      f.xAxis(categories: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'])
      f.yAxis({ 
        title: { text: "Temperature (C)" } 
        })
      f.plotOptions({
          line: {
            dataLabels: { enabled: true },
            enableMouseTracking: true
          }
        })
    end
  end
 
  def create
    #render text: project_params.merge( user_id: current_user.id)
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
