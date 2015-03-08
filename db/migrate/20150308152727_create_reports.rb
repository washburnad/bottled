class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.string :name
      t.integer :reportable_id
      t.string :reportable_type
      t.datetime :start_date
      t.datetime :end_date
      t.timestamps
    end

    add_index :reports, :reportable_id
  end
end
