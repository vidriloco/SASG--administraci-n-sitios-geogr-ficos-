# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100709024619) do

  create_table "ESTACION", :id => false, :force => true do |t|
    t.integer "ID",                        :null => false
    t.point   "COORDENADA", :limit => nil
    t.string  "DELEGACION", :limit => 256
    t.string  "ID_NOMBRE",  :limit => 256
    t.string  "NOMBRE",     :limit => 256
  end

  create_table "ESTACIONES", :id => false, :force => true do |t|
    t.integer "ESTACIONES_ID", :limit => 8,   :null => false
    t.point   "COORDENADA",    :limit => nil,                 :srid => 4326
    t.string  "DELEGACION",    :limit => 256
    t.string  "ID_NOMBRE",     :limit => 256
    t.string  "NOMBRE",        :limit => 256
    t.integer "ID"
  end

  create_table "categorias", :force => true do |t|
    t.string   "nombre"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "categorias", ["nombre"], :name => "index_categorias_on_nombre"

  create_table "colonias", :force => true do |t|
    t.string   "nombre"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "colonias_estaciones", :id => false, :force => true do |t|
    t.integer  "colonia_id"
    t.integer  "estacion_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "correspondencias", :force => true do |t|
    t.string   "clave"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "estaciones", :force => true do |t|
    t.string   "nombre"
    t.integer  "correspondencia_id"
    t.integer  "linea_id"
    t.string   "delegacion"
    t.float    "posicion"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.point    "coordenada",         :limit => nil, :null => false, :srid => 4326
  end

  add_index "estaciones", ["coordenada"], :name => "index_estaciones_on_coordenada", :spatial => true

  create_table "imagenes", :force => true do |t|
    t.string   "nombre_de_archivo"
    t.string   "nombre"
    t.string   "mime"
    t.text     "descripcion"
    t.integer  "sitio_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "lineas", :force => true do |t|
    t.string            "nombre"
    t.integer           "transporte_id"
    t.string            "identificador"
    t.string            "color"
    t.datetime          "created_at"
    t.datetime          "updated_at"
    t.multi_line_string "trazo",         :limit => nil, :null => false, :srid => 4326
  end

  add_index "lineas", ["trazo"], :name => "index_lineas_on_trazo", :spatial => true

  create_table "sitios", :force => true do |t|
    t.string   "nombre"
    t.integer  "categoria_id"
    t.text     "descripcion"
    t.string   "direccion"
    t.integer  "telefono"
    t.string   "sitioweb"
    t.string   "correo"
    t.boolean  "lucrativo"
    t.integer  "identificador_dir"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.point    "coordenada",        :limit => nil, :null => false, :srid => 4326
  end

  add_index "sitios", ["coordenada"], :name => "index_sitios_on_coordenada", :spatial => true

  create_table "transportes", :force => true do |t|
    t.string   "nombre"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
