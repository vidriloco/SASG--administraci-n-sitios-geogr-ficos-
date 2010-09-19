module Compartido
    
  def self.included receiver
      receiver.extend ClassMethods
      receiver.class_eval do
        #@associated, @non_associated, @key_names = [], [], {}
        @respaldables = []
        @diccionario = {}
        #def self.es_evaluable(atributo)
        #  hash_atributos={}
        #  return hash_atributos[atributo]
        #end
      end
  end
    
  def attributes_which_are(symbol)
    return self.class.get_attributes(symbol)
  end
    
  def lookup_key(key)
    return self.class.get_mapped_key(key)
  end
  
  def drop_attribute_which_is(symbol, atr)
    return self.class.drop_attribute(symbol, atr)
  end
  
  # Devuelve un arreglo con los id's de los instancias de los modelos relacionados a ésta instancia
  # INPUT: Symbol, modelo relacionado (plural)
  # OUTPUT: Array, id's
  def ids_of(related_model)
    eval("self.#{related_model.to_s}.inject([]) {|array, obj|  array<< obj.id; array}")
  end
      
  module ClassMethods
    
    def atributos_respaldables(array)
      raise "Debe ser un arreglo" unless array.is_a? Array
      @respaldables = array
    end
    
    def respaldables
      @respaldables
    end
    
    def diccionario_de_atributos_respaldables(hash)
      raise "Debe ser un hash" unless hash.is_a? Hash
      @diccionario = hash
    end
    
    def diccionario
      @diccionario
    end
    
    #def get_attributes(symbol)
    #  if symbol.eql? :associated
    #    @associated
    #  elsif symbol.eql? :non_associated
    #    @non_associated
    #  end
    #end
 
    #def drop_attribute(symbol, atribute)
    #  if symbol.eql? :associated
    #    @associated.delete(atribute)
    #  elsif symbol.eql? :non_associated
    #    @non_associated.delete(atribute)
    #  end
    #end

    #def attributes_to_serialize(*args)
    #  args.each do |arg|
    #   if arg.is_a? Hash
    #     @associated += arg[:associated]
    #   elsif arg.is_a? Symbol
    #     @non_associated << arg
    #   end
    #  end
    #end

    #def remap_names(names_hash)
    #  @key_names = names_hash
    #end

    #def get_mapped_key(key)
    #  @key_names[key]
    #end
  end   
end