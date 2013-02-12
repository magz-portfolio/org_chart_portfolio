class OrgChart < ActiveRecord::Base
	has_one :root_node, class_name: "OrgChartNode"
	attr_accessible :name
	def get_all_nodes
		([root_node] + root_node.get_all_children).flatten
	end
end