class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.string :description
      t.integer :task_id
      t.integer :start_time
      t.integer :end_time
      t.integer :duration

      t.timestamps
    end
  end
end
