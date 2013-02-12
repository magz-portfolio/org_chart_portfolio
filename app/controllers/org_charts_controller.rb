class OrgChartsController < ApplicationController
	def index
		@org_charts = OrgChart.all

		render json: {org_charts: @org_charts}
	end

	def show
		@org_chart = OrgChart.find(params[:id])
		render json: {org_chart: @org_chart, nodes: @org_chart.get_all_nodes} 
	end

	def create
		#so i'm requiring that you create the root node along with the chart
		#i'm not 100% thrilled with this, but it makes a few other things a lot simpler
		@root_node = OrgChartNode.new(employee_name: params["rootNode"]["employeeName"],
									employee_job: params["rootNode"]["employeeJob"])
		@org_chart = OrgChart.new(name: params["orgChart"]["name"])
		@org_chart.root_node = @root_node
		@root_node.org_chart = @org_chart

		created = false
		ActiveRecord::Base.transaction do
				@root_node.save!

				@org_chart.save!
				created = true
		
		end
		if created
			render json: {org_chart: @org_chart, 
						root_node: @root_node, 
						status: :created}
		else
			render json: {errors: errors, status: :unprocessable_entity}
		end


	end



end