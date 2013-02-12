class CreateOrgChartNode < ActiveRecord::Migration
  def change
    create_table :org_chart_nodes do |t|
      t.integer :tree_id
      t.string :employee_name
      t.string :employee_job_title
      t.integer :parent_node_id
      t.timestamps
    end
  end
end
