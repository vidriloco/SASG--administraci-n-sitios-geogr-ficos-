class CreateCorrespondencias < ActiveRecord::Migration
  def self.up
    create_table :correspondencias do |t|
      t.string :clave
      
      t.timestamps
    end
  end

  def self.down
    drop_table :correspondencias
  end
end
