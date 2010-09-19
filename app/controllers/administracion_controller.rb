class AdministracionController < ApplicationController
  
  def index
  end
  
  def limpia_bd
    Utilidades.limpia_bd(["Linea", "Estacion", "Transporte", "Correspondencia", "Colonia"])
    redirect_to("/")
  end
  
  def salida_rb
    path = Utilidades.migracion_exporta_rb({:transporte => [:linea], 
                                            :linea => [:estacion], 
                                            :correspondencia => [:estacion],
                                            :colonia => [:estacion]})
    send_file path, :disposition => 'attachment', :filename => "copia_de_seguridad_#{DateTime.now.to_s(:short)}.rb"
  end
  
  def entrada_rb
    archivo=params[:zipo]
    Utilidades.migracion_importa_rb(archivo)
    redirect_to("/")
  end
  
end
