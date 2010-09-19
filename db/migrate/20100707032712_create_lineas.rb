class CreateLineas < ActiveRecord::Migration
  def self.up
    create_table :lineas, :force => true do |t|
      t.string :nombre
      t.integer :transporte_id
      t.string :identificador
      t.string :color
      t.multi_line_string :trazo, :null => false, :srid => 4326, :with_z => false

      t.timestamps
    end
    add_index :lineas, :trazo, :spatial => true
  end

  def self.down
    drop_table :lineas
  end
end
