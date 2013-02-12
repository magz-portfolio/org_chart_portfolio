class CreateOrgChart < ActiveRecord::Migration
  def change
    create_table :org_charts do |t|
      t.timestamps
    end
  end
end
