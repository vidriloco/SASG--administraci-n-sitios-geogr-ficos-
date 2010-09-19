class CreateImagenes < ActiveRecord::Migration
  def self.up
    create_table :imagenes do |t|
      t.string :nombre_de_archivo
      t.string :nombre
      t.string :mime
      t.text :descripcion
      t.integer :sitio_id

      t.timestamps
    end
  end

  def self.down
    drop_table :imagenes
  end
end
