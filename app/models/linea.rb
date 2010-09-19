class Linea < ActiveRecord::Base
  include Compartido
  
  belongs_to :transporte
  has_many :estaciones
    
  atributos_respaldables [:nombre, :identificador, :color, :trazo_exp]
  diccionario_de_atributos_respaldables :trazo_exp => :trazo
  
  def trazo_exp
    multi_line_str = String.new
    # MultiLineString
    trazo.to_a.each do |ls|
      #LineString
      line_string_a = String.new
      ls.each do |t| 
        line_string_a+="[#{t.lon}, #{t.lat}],"
      end
      line_string_a.chop!
      multi_line_str += "LineString.from_coordinates([#{line_string_a}]),"
    end
    "$MultiLineString.from_line_strings([#{multi_line_str.chop!}], 4326)"
  end
  
  def escribe_xml
    s=to_xml
    f=File.open("salida.xml", "w+")
    f.write(s)
    f.close
  end
  
  def estaciones_ordenadas
    Estacion.find(:all, :order => "posicion ASC", :conditions => {:linea_id => self.id})
  end
  
  def to_xml(options={}, &block)
    super(options.merge(:except => [:id, :created_at, :updated_at, :transporte_id, :trazo])) do |xml|
      xml.trazos do
        self.trazo.each do |t|
          xml.trazo do
            puntos=String.new
            t.each do |punto|
              puntos << "#{punto.lon},#{punto.lat} "
            end
            puntos.chop!
            xml.coordenadas puntos
          end
        end
      end
      xml.estaciones do
        self.estaciones_ordenadas.each do |estacion| 
          xml.estacion do
            xml.nombre estacion.nombre
            xml.delegacion estacion.delegacion
            xml.posicion estacion.posicion
            xml.coordenada do
              xml.lon estacion.coordenada.lon
              xml.lat estacion.coordenada.lat
            end
            xml.colonias do
              estacion.colonias.each { |col| xml.colonia col.nombre }
            end
            xml.correspondencias do
              estacion.correspondencias.each do |c|
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
    end
  end
end
