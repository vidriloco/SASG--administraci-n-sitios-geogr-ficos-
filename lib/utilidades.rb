require 'migrador'

class Utilidades
  
  # {:plaza => [:paquete, :servicio], :zona => [:paquete], :servicio => [:concepto], :metasubservicio => [:servicio], 
  #  :metaconcepto => [:concepto], :metaconcepto => [:metaservicio], :estado => [:plaza]} 
  # Método que exporta un conjunto de instancias de modelos relacionados a una representación de dicha relación mediante
  # código ruby, haciéndo uso de ActiveRecord.
  def self.migracion_exporta_rb(modelos_hash=nil)
    
    migrador=Migrador.new                    
    cadena_guardados=String.new
    
    #funcion para generar codigo ruby de cada tupla en la tabla modelo
    modelo_creator = Proc.new do |modelo|
      puts "Escribiendo: #{modelo}"
      atributos_modelo = modelo.to_s.capitalize.constantize.respaldables
      dicc_modelo = modelo.to_s.capitalize.constantize.diccionario
      puts "Con atributos: #{atributos_modelo}"
      cadena_final = String.new
      
      modelo.to_s.capitalize.constantize.all.each do |m|
        hash_cadena=String.new

        atributos_modelo.each do |atr|
          valor = m.send(atr).nil? ? "\"\"" : (m.send(atr).to_s.start_with?("$") ? m.send(atr).gsub!("$", "") : "\"#{m.send(atr)}\"")
            
          atributo = dicc_modelo.has_key?(atr) ? dicc_modelo[atr] : atr            
          hash_cadena << ":#{atributo.to_s} => #{valor},"
        end
        puts "Valores de cadena: #{hash_cadena}"
        unless hash_cadena.blank?
          hash_cadena.chop!
        end
        cadena_modelo = "#{modelo.to_s.downcase}_#{m.id} = #{modelo.to_s.capitalize}.create(#{hash_cadena})\n"
        migrador.agrega_marcado(modelo.to_s.downcase, m.id) ? (cadena_guardados << "#{modelo.to_s.downcase}_#{m.id}.save\n") : false
        cadena_final << cadena_modelo
        
      end
      cadena_final
    end
    
    #funcion para generar codigo ruby de cada tupla en la tabla modelo
    # segunda pasada en la que se escriben a las instancias asociadas
    liga_modelos = Proc.new do |modelo_has_many, modelo_belongs_to|
      puts "Escribiendo asociado: #{modelo_belongs_to} a: #{modelo_has_many}"
    
      cadena_final = String.new
      
      modelo_belongs_to.to_s.capitalize.constantize.all.each do |m|
        if m.respond_to?(modelo_has_many)
          puts "No plural"
          m_id=m.send(modelo_has_many)
          if m_id != nil
            cadena_modelo = "#{modelo_belongs_to.to_s.downcase}_#{m.id}.#{modelo_has_many} = #{modelo_has_many}_#{m_id.id}\n"
            cadena_final << cadena_modelo
          end
        elsif m.respond_to?(modelo_has_many.to_s.pluralize)
          puts "Plural"
          m_id=m.send(modelo_has_many.to_s.pluralize)
          if !m_id.empty?
            m_id.each do |mid|
              cadena_modelo = "#{modelo_belongs_to.to_s.downcase}_#{m.id}.#{modelo_has_many.to_s.pluralize} << #{modelo_has_many}_#{mid.id}\n"
              cadena_final << cadena_modelo
            end
          end
        end
        if migrador.agrega_marcado(modelo_belongs_to.to_s.downcase, m.id) 
           cadena_guardados << "#{modelo_belongs_to.to_s.downcase}_#{m.id}.save\n"
        end
      end
      
      cadena_final
    end
    puts "Inciando..."
    cadena_de_salida=String.new
    puts "Datos de entrada: #{modelos_hash}"
    # Devuelve la llave que es un modelo en simbolo (ie {:modelo1 => -----} )
    modelos_hash.each_key do |key_modelo|
      puts "Tratando con: #{key_modelo}"
      unless migrador.tabla_ya_escrita?(key_modelo)
        puts "No escrita aun: #{key_modelo}"
        cadena_de_salida << modelo_creator.call(key_modelo)
        migrador.registra_tabla(key_modelo)
      end
    end
        
    modelos_hash.each_pair do |key, value|
      puts "Segunda pasada con: #{key}"
      value.each do |invalue|
        puts "Repasando: #{invalue}"
        unless migrador.tabla_ya_escrita?(invalue)
          cadena_de_salida << modelo_creator.call(invalue)
          migrador.registra_tabla(invalue)
        end
        cadena_de_salida << liga_modelos.call(key, invalue)
      end
    end
    
    t = Tempfile.new("migracion_db_ruby.rb")
    #Backup.actualiza_hash(cadena_de_salida+cadena_guardados)
    File.open(t.path, "wb") do |f|
      f.write cadena_de_salida
      f.write cadena_guardados
    end
    t.path
  end
  
  # Método que lee un archivo escrito en código ruby y evalua su contenido.
  # Se espera que tal archivo contenga código relacíonado a registros de una base de datos antigua
  # que se incorporaran a la base de datos actual mediante ActiveRecord.
  def self.migracion_importa_rb(archivo)
    f=File.open(archivo.path)
    datos = f.read
    f.close
    # Verificar si el archivo se mantuvo intacto desde que se generó.
    #if Backup.hash_es_el_mismo(datos)
      eval(datos)
      true
    #else
    #  false
    #end
  end
  
  # Método de purga de la base de datos. Excluye de ser eliminado al usuario actual y a su rol asociado.
  def self.limpia_bd(modelos)
    return if modelos.empty?
    modelos.map { |modelo| modelo.capitalize.constantize.destroy_all }
  end
end