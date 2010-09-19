# coding:utf-8
class Correspondencia < ActiveRecord::Base
  include Compartido
  has_many :estaciones
  validates_uniqueness_of :clave, :message => "debe ser único"
  validates_presence_of :clave, :message => "no debe ir vacío"
  
  atributos_respaldables [:clave]
  
  def self.escribe_todos_a_xml
    s=all.to_xml
    f=File.open("correspondencias.xml", "w+")
    f.write(s)
    f.close
  end
  
  def to_xml(options={}, &block)
    super(options.merge(:except => [:id, :created_at, :updated_at])) do |xml|
      xml.estaciones do
        self.estaciones.each do |e|
          xml.estacion do
            xml.nombre e.nombre
            xml.linea do
              xml.identificador e.linea.identificador
              xml.transporte do
                xml.nombre e.linea.transporte.nombre
              end
            end
          end
        end
      end
    end 
  end
  
end
