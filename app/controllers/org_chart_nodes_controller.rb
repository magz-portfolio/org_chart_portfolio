class OrgChartNodesController < ApplicationController


	def create
		puts params
		puts params[:org_chart_node]
		
    @org_chart_node = OrgChartNode.new()
		@org_chart_node.employee_name = params[:org_chart_node]["employeeName"]
 		@org_chart_node.employee_job = params[:org_chart_node]["employeeJob"]
 		@org_chart_node.parent_node = OrgChartNode.find params[:org_chart_node]["parentNodeId"]
 		@org_chart_node.org_chart = @org_chart_node.parent_node.org_chart
    
    respond_to do |format|
      if @org_chart_node.save
        # format.html { redirect_to @org_chart_node, notice: 'Email template was successfully created.' }
        format.json { render json: {org_chart_node: @org_chart_node, status: :created}}
      else
        # format.html { render action: "new" }
        format.json { render json: @org_chart_node.errors, status: :unprocessable_entity }
      end
    end
		
	end

  def update
    @node = OrgChartNode.find params[:node][:id]
    @node.employee_name = params[:node][:employeeName]
    @node.employee_job = params[:node][:employeeJob]
      if @node.save!
        render json: {node: @node, status: :ok }
      else
        render json: {status: :unprocessable_entity }
      end


  end

  def move_node
    @node = OrgChartNode.find params["targetNodeId"]
    @new_parent_node = OrgChartNode.find params["newParentId"]

    unless @node.get_all_children.include?(@new_parent_node) 
        @node.parent_node = @new_parent_node
        if @node.save!
          render json: {node: @node, status: :ok }
        else
          render json: {node: @node, status: :ok }
        end
    else
      render json: {errors: @node.errors, status: :unprocessable_entity }
    end
  end

  def destroy
    node = OrgChartNode.find params["org_chart_node"][:targetNodeId]
    if node.parent_node.id == params["org_chart_node"][:parentNodeId].to_i
      ActiveRecord::Base.transaction do 
        node.children.each do |child|
          child.parent_node = node.parent_node
          child.save!
          node.destroy
        end
        render json: {status: :ok}
      end
    else
      puts "INVALID PARENTID / CHILD ID"
      render json: {status: :unprocessable_entity}
    end

    
  end

  

end