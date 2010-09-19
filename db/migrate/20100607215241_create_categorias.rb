class CreateCategorias < ActiveRecord::Migration
  def self.up
    create_table :categorias do |t|
      t.string :nombre

      t.timestamps
    end
    add_index :categorias, :nombre
  end

  def self.down
    drop_table :categorias
  end
end
