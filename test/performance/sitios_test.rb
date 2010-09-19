require 'test_helper'
require 'rails/performance_test_help'

class SitiosTest < ActionController::PerformanceTest
  # Replace this with your real tests.
  def test_index_by
    # Buscando puntos dentro de cc y ce (radial) que cumplan con ser categorias de tipo Prueba, Hospital, Plaza, Parque
    get '/entre', :params => {:cc => "-99.146118, 19.352287", :ce => "-99.130583, 19.349777", :categorias => "Prueba, Hospital, Plaza, Parque"}
  end
end
