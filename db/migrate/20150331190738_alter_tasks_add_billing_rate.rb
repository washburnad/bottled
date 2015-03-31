class AlterTasksAddBillingRate < ActiveRecord::Migration
  def change
    add_column :tasks, :billing_rate, :decimal, :precision => 2, :scale => 2
  end
end
