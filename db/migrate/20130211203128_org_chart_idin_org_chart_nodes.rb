class OrgChartIdinOrgChartNodes < ActiveRecord::Migration
  def up
  	rename_column :org_chart_nodes, :tree_id, :org_chart_id
  end

  def down
  	rename_column :org_chart_nodes, :org_chart_id, :tree_id
  end
end
