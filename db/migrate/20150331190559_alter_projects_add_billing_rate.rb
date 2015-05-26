class AlterProjectsAddBillingRate < ActiveRecord::Migration
  def change
    add_column :projects, :billing_rate, :decimal, :precision => 2, :scale => 2
  end
end
