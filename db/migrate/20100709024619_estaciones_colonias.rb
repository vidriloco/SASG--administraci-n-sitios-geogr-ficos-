class EstacionesColonias < ActiveRecord::Migration
  def self.up
    create_table :colonias_estaciones, :id => false do |t|
      t.integer :colonia_id
      t.integer :estacion_id
      t.timestamps
    end
  end

  def self.down
    drop_table :colonias_estaciones
  end
end
