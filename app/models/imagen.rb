class Imagen < ActiveRecord::Base
  belongs_to :sitio
  validates_presence_of :nombre, :message => "No puede ir en blanco"
  
  after_save :guarda_archivo
  before_destroy :elimina_archivo
  
  attr_accessor :archivo_tmp
  
  def archivo=(entrada)
    self.archivo_tmp = entrada
    self.mime = entrada.content_type
    self.nombre_de_archivo = entrada.original_filename
  end
  
  def guarda_archivo
    Dir.mkdir("#{RAILS_ROOT}/data/sitios/#{self.sitio.id}/#{self.id}") unless File.exists?("#{RAILS_ROOT}/data/sitios/#{self.sitio.id}/#{self.id}")
    File.open("#{RAILS_ROOT}/data/sitios/#{self.sitio.id}/#{self.id}/#{self.nombre_de_archivo}", 'w') do |file|
         file.write archivo_tmp.read
    end
  end
  
  def elimina_archivo
    if File.exists?("#{RAILS_ROOT}/data/sitios/#{self.sitio.id}/#{self.id}/#{self.nombre_de_archivo}")
      FileUtils.rm_rf("#{RAILS_ROOT}/data/sitios/#{self.sitio.id}/#{self.id}") 
    end
  end
  
  def ruta_al_archivo
    "#{RAILS_ROOT}/data/sitios/#{self.sitio.id}/#{self.id}/#{self.nombre_de_archivo}"
  end
  
  def to_xml(options={}, &block)
    super(options.merge(:only => [:id, :nombre, :descripcion]))
  end
end
