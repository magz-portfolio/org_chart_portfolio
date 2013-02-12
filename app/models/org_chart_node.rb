class OrgChartNode < ActiveRecord::Base
	belongs_to :org_chart
	
	belongs_to :parent_node, class_name: "OrgChartNode", foreign_key: :parent_node_id
	has_many :children, class_name: "OrgChartNode", foreign_key: :parent_node_id

	attr_accessible :org_chart, :employee_name, :employee_job, :parent_node

	
	def get_all_children
		(self.children + self.children.map {|x| x.get_all_children}).flatten
	end

	def self.magz
		OrgChartNode.find_by_employee_name "magz"
	end
	def self.casey
		OrgChartNode.find_by_employee_name "casey"
	end
	def self.cav
		OrgChartNode.find_by_employee_name "cav"
	end
	def self.lauren
		OrgChartNode.find_by_employee_name "lauren"
	end

end