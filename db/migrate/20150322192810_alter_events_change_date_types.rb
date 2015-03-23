class AlterEventsChangeDateTypes < ActiveRecord::Migration
  def change
    remove_column :events, :end_time
    remove_column :events, :start_time

    add_column :events, :start_time, :datetime
    
    add_index :events, :start_time
    add_index :events, :task_id
  end
end
