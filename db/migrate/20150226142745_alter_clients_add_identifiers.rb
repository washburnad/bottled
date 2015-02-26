class AlterClientsAddIdentifiers < ActiveRecord::Migration
  def change
  	add_column :clients, :glyph_id, :text, :default => '&#xE022;'
  	add_column :clients, :glyph_color, :text, :default => '#c48219'
  end
end
