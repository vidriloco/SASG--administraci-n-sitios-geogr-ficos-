# coding: utf-8
namespace :sitios do
  
  desc "Generador de sitios de prueba"
  
  task :popula => :environment do
    Rake::Task["db:seed"].execute
  end
  
  task :genera => :popula do
    lon_base = -99.100000
    lat_base = 19.240000
    categorias = Categoria.all
    num_cat = 0
    0.upto(500).each do |numero|
      categorias.each do |c|
        # .24 - .43 para lat_base en 0.2*rand
        # .24 - .46 para lat_base en 0.25*rand
        s=Sitio.new(:nombre => "Prueba número #{num_cat}", 
                    :coordenada => {:lon => lon_base-(rand*0.2).to_f, :lat => lat_base+(rand*0.3).to_f},
                    :categoria => c, 
                    :descripcion => "Ésta es una descripción para la prueba #{numero}",
                    :correo => "sit.prueba@sit.com.mx",
                    :sitioweb => "www.sit.com.mx",
                    :telefono => rand(5)*77777,
                    :direccion => "Una dirección genérica",
                    :lucrativo => false)
        num_cat+=1
        s.save!
        puts "Generando sitio #{num_cat}" if (num_cat % 1000 == 0)
        
      end
    end
  end
end