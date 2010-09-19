class CreateTransportes < ActiveRecord::Migration
  def self.up
    create_table :transportes do |t|
      t.string :nombre

      t.timestamps
    end
  end

  def self.down
    drop_table :transportes
  end
end
