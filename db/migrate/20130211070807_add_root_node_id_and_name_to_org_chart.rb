class AddRootNodeIdAndNameToOrgChart < ActiveRecord::Migration
  def up
  	add_column :org_charts, :name, :string
   	add_column :org_charts, :root_node_id, :integer
  end

  def down
  	 remove_column :org_charts, :name
  	 remove_column :org_charts, :root_node_id

  end
end
