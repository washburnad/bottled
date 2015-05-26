class CreateCollaborations < ActiveRecord::Migration
  def change
    create_table :collaborations do |t|
      t.integer :client_id
      t.integer :user_id
      t.timestamps
    end

    add_index :collaborations, [:client_id, :user_id]
    add_index :collaborations, :client_id
    add_index :collaborations, :user_id
  end
end
