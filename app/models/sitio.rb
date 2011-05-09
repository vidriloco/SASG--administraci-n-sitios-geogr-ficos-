class Sitio < ActiveRecord::Base
  belongs_to :categoria
  has_many :imagenes, :dependent => :destroy
  before_save :coordenada_a_punto
  after_save :crea_directorio_de_datos
  
  before_destroy :elimina_directorio_de_datos
  
  def crea_directorio_de_datos
     elimina_directorio_de_datos
     Dir.mkdir("#{RAILS_ROOT}/data/sitios/#{self.id}")
  end
  
  def elimina_directorio_de_datos
     FileUtils.rm_rf("#{RAILS_ROOT}/data/sitios/#{self.id}") if File.exists?("#{RAILS_ROOT}/data/sitios/#{self.id}")
  end
  
  def coordenada_a_punto
    unless self.coordenada.instance_of? Point
      self.coordenada = Point.from_lon_lat(self.coordenada[:lon].to_f, self.coordenada[:lat].to_f, 4326)
    end
  end
  
  def coordenada_to_s
    "Lat: #{self.coordenada.lat} Long: #{self.coordenada.lon}"
  end
  
  def self.encuentra_dentro_de_radio(pt, dist = 0.01, cats)
    generico=generico="categorias.nombre=? OR "*(cats.length-1)
    generico+="categorias.nombre=?"
    
    condiciones = ["ST_DWithin(coordenada, ST_GeomFromText('POINT(#{pt.x} #{pt.y})', 4326), #{dist}) AND #{generico}"]
    cats.each do |cat|
      condiciones << cat
    end
    self.all(:joins => :categoria, :conditions => condiciones)
  end
  
  def to_xml(options={}, &block)
    super(options.merge(:except => [:categoria_id, :coordenada, :created_at, :updated_at], :include => [:imagenes])) do |xml|
      xml.coordenada do
        xml.lat self.coordenada.lat
        xml.lon self.coordenada.lon
      end
      xml.lucrativo self.lucrativo ? "Si" : "No"
      unless categoria.nil?
        xml.categoria do
          xml.nombre self.categoria.nombre
        end
      end
    end
  end
  
end
