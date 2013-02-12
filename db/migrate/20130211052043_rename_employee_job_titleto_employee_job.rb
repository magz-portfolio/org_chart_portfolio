class RenameEmployeeJobTitletoEmployeeJob < ActiveRecord::Migration
  def up
  	rename_column :org_chart_nodes, :employee_job_title, :employee_job
  end

  def down
  	 rename_column :org_chart_nodes, :employee_job, :employee_job_title
  end
end
