# coding: utf-8
class Colonia < ActiveRecord::Base
  include Compartido
  has_and_belongs_to_many :estaciones
  validates_presence_of :nombre, :message => "no debe ir vacío"
  validates_uniqueness_of :nombre, :message => "debe ser único"
  
  atributos_respaldables [:nombre]
  
end
