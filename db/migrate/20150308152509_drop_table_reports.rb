class DropTableReports < ActiveRecord::Migration
  def change
    drop_table :reports
  end
end
