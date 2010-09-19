class CreateColonias < ActiveRecord::Migration
  def self.up
    create_table :colonias do |t|
      t.string :nombre

      t.timestamps
    end
  end

  def self.down
    drop_table :colonias
  end
end
