class ProjectsController < ApplicationController
  include ApplicationHelper
  before_action :authenticate_user!
  before_action :set_project, only: [ :show, :edit, :update, :destroy ]
  before_action :no_header_footer!, only: [ :show ]
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
    # @chart = LazyHighCharts::HighChart.new('graph') do |f|
    #   f.title(text: fl(@project.name))
    #   f.subtitle(text: @project.description)
    #   @project.items.each do |i|
    #     f.series( name: i.name, data: i.track_items.map { |ti| ti.user_data }) 
    #   end
    #   f.xAxis(type: "datetime")
    #   f.yAxis({ 
    #     title: { text: "Performance" } 
    #     })
    #   f.plotOptions({
    #       line: {
    #         dataLabels: { enabled: true },
    #         enableMouseTracking: true
    #       }
    #     })
    #   f.chart({ defaultSeriesType: "line" })
    # end

    # @chart = LazyHighCharts::HighChart.new('column') do |f|
    #        f.series(:name=>'Correct',:data=> [1, 2, 3, 4, 5])
    #        f.series(:name=>'Incorrect',:data=> [10, 2, 3, 1, 4] )       
    #        f.title({ :text=>"clickable bar chart"})
    #        f.legend({:align => 'right', 
    #                 :x => -100, 
    #                 :verticalAlign=>'top',
    #                 :y=>20,
    #                 :floating=>"true",
    #                 :backgroundColor=>'#FFFFFF',
    #                 :borderColor=>'#CCC',
    #                 :borderWidth=>1,
    #                 :shadow=>"false"
    #                 })
    #        f.options[:chart][:defaultSeriesType] = "column"
    #        f.options[:xAxis] = {:plot_bands => "none", :title=>{:text=>"Time"}, :categories => ["1.1.2011", "2.1.2011", "3.1.2011", "4.1.2011", "5.1.2011"]}
    #        f.options[:yAxis][:title] = {:text=>"Answers"}
    #        f.options[:plot_options][:column] = {:stacking=>'normal', 
    #           :cursor => 'pointer',
    #           :point => {:events => {:click => "myAlert"}}
    #        }  
    #     end
    
    # data = Net::HTTP.get(URI.parse("http://www.highcharts.com/samples/data/jsonp.php?filename=aapl-c.json&callback=?"))
  
    @stock = LazyHighCharts::HighChart.new('stock') do |f|
      f.rangeSelector(selected: 1, inputEnabled: true)
      f.title( text: fl(@project.name))
      @project.items.each do |i| 
        @data = i.track_items.map {|tr| [tr.created_at.to_i * 1000, tr.user_data] }
        f.series(name: i.name, 
                  data: @data,
                  tooltip: { valueDecimals: 2},
                  marker: { enabled: true, radius: 3},
                  shadow: true)
      end
      f.legend(enabled: true)
      f.plotOptions(spline: { turboThreshold: 2000})
      f.credits(enabled: false)
    end

    # $('#container').highcharts('StockChart', {


    #         rangeSelector : {
    #             selected : 1,
    #             inputEnabled: $('#container').width() > 480
    #         },

    #         title : {
    #             text : 'AAPL Stock Price'
    #         },

    #         series : [{
    #             name : 'AAPL',
    #             data : data,
    #             tooltip: {
    #                 valueDecimals: 2
    #             }
    #         }]
    #     });
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
