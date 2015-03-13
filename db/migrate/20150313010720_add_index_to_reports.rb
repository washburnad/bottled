class AddIndexToReports < ActiveRecord::Migration
  def change
    add_index :reports, [:reportable_id, :reportable_type]
    remove_index :reports, :reportable_id
  end
end
