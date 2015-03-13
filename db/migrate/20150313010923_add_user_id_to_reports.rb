class AddUserIdToReports < ActiveRecord::Migration
  def change
    add_column :reports, :user_id, :integer, null: :false
    add_index :reports, :user_id
  end
end
