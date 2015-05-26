class AlterEventsChangeDuration < ActiveRecord::Migration
  def change
    change_column :events, :duration, :decimal, :precision => 8, :scale => 2
  end
end
