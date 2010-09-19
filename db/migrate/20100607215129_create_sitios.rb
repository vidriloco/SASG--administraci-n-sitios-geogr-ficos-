class CreateSitios < ActiveRecord::Migration
  def self.up
    
    #execute "CREATE LANGUAGE plpgsql;"
    #execute "\i '/opt/local/share/postgresql84/contrib/postgis-1.5/postgis.sql';"
    #execute "\i '/opt/local/share/postgresql84/contrib/postgis-1.5/spatial_ref_sys.sql';"
    
    create_table :sitios, :force => true do |t|
      t.string :nombre
      t.integer :categoria_id
      t.point :coordenada, :null => false, :srid => 4326, :with_z => false
      t.text :descripcion
      t.string :direccion
      t.integer :telefono
      t.string :sitioweb
      t.string :correo
      t.boolean :lucrativo
      t.integer :identificador_dir

      t.timestamps
    end
    
    add_index :sitios, :coordenada, :spatial => true
    execute "CLUSTER index_sitios_on_coordenada ON sitios;"
  end

  def self.down
    drop_table :sitios
  end
end
