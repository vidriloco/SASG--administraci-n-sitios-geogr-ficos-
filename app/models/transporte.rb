class Transporte < ActiveRecord::Base
  include Compartido
  has_many :lineas
  
  atributos_respaldables [:nombre]
  
  def to_xml(options={}, &block)
    super(options.merge(:except => [:id, :created_at, :updated_at], :include => [:lineas]))
  end
  
  def self.escribe_todos_a_xml
    s=all.to_xml
    f=File.open("rutas.xml", "w+")
    f.write(s)
    f.close
  end
end
