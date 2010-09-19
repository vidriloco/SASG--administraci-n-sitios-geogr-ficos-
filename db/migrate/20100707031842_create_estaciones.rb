class CreateEstaciones < ActiveRecord::Migration
  def self.up
    create_table :estaciones, :force => true do |t|
      t.string :nombre
      t.integer :correspondencia_id
      t.point :coordenada, :null => false, :srid => 4326, :with_z => false
      t.integer :linea_id
      t.string :delegacion
      t.float :posicion
      t.timestamps
    end
    add_index :estaciones, :coordenada, :spatial => true
  end

  def self.down
    drop_table :estaciones
  end
end
