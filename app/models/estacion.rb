# coding: utf-8
require 'csv'
require 'iconv'
require 'cgi'

class Estacion < ActiveRecord::Base
  include Compartido
  
  has_and_belongs_to_many :colonias
  belongs_to :correspondencia
  belongs_to :linea
  
  validates_presence_of :coordenada, :message => "no debe ir vacío"
  validates_presence_of :nombre, :message => "no debe ir vacío"
  
  before_save :coordenada_a_punto
  before_validation :verifica_coordenada
  
  atributos_respaldables [:nombre, :coordenada_exp, :delegacion, :posicion]
  diccionario_de_atributos_respaldables :coordenada_exp => :coordenada
  
  def coordenada_to_s
    "Lat: #{self.coordenada.lat} Long: #{self.coordenada.lon}"
  end
  
  def verifica_coordenada
    unless self.coordenada.is_a? Point
      if self.coordenada[:lat].empty? or self.coordenada[:lon].empty?
        self.errors.add(:coordenada, "no puede ir vacío")
        self.coordenada = nil
      end
    end
  end
  
  def coordenada_a_punto
    unless self.coordenada.instance_of? Point
      self.coordenada = Point.from_lon_lat(self.coordenada[:lon], self.coordenada[:lat], 4326)
    end
  end
    
  def coordenada_exp
    "$Point.from_lon_lat(#{coordenada.lon}, #{coordenada.lat}, 4326)"
  end
  
  def self.desde_csv
    CSV.open("estaciones.csv", 'r').each do |ren|
      lon = ren[0].to_f
      lat = ren[1].to_f
      nombre = ren[2]
      linea = Linea.find(:first, :conditions => "nombre = '#{ren[3]}'")
      raise("Linea no encontrada") if linea.nil?
      puts "Procesando estación: #{nombre} de línea: #{linea.nombre}"
      nueva_estacion = self.new(:nombre => nombre, :coordenada => Point.from_lon_lat(lon, lat, 4326))
      nueva_estacion.linea = linea
      nueva_estacion.save!
    end
  end
  
  def correspondencias
    return [] if correspondencia.nil?
    ests= correspondencia.estaciones.clone
    ests.delete(self)
    ests
  end
  
  def escribe_xml
    s=to_xml
    f=File.open("salida.xml", "w+")
    f.write(s)
    f.close
  end
  
  def archivo
    diccionario = {'ñ' => 'n', 'Ñ' => 'N', 
                   'Á' => 'A', 'á' => 'a',
                   'É' => 'E', 'é' => 'e',
                   'Í' => 'I', 'í' => 'i',
                   'Ó' => 'O', 'ó' => 'o',
                   'Ú' => 'U', 'ú' => 'u',
                   'Ä' => 'A', 'ä' => 'a',
                   'Ë' => 'E', 'ë' => 'e',
                   'Ï' => 'I', 'ï' => 'i',
                   'Ö' => 'O', 'ö' => 'o',
                   'Ü' => 'U', 'ü' => 'u',
                   "." => "", "/" => ""}
    
    nombre_nuevo = nombre.each_char.inject(String.new) do |resultado, elemento| 
      resultado += (diccionario.has_key?(elemento) ? diccionario[elemento] : elemento)
    end
    nombre_nuevo
  end
  
  def to_xml(options={}, &block)
    super(options.merge(:except => [:id, :created_at, :updated_at, :id_nombre, :coordenada, :linea_id, :correspondencia_id])) do |xml|
      xml.coordenada do
        xml.lon self.coordenada.lon
        xml.lat self.coordenada.lat
      end
      xml.colonias do
        self.colonias.each { |col| xml.colonia col.nombre }
      end
      xml.correspondencias do
        self.correspondencias.each do |c|
          linea = c.linea
          xml.correspondencia do
            xml.nombre linea.nombre
            xml.transporte linea.transporte.nombre
            xml.identificador linea.identificador
          end
        end
      end
      
    end
  end
  
end
