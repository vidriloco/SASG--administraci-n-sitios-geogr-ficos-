#coding:utf-8
class EstacionesController < ApplicationController
  
  before_filter :colecciones_a_usar, :except => [:index, :show, :destroy]
  
  def colecciones_a_usar
    @transportes = Transporte.all
    @correspondencias = Correspondencia.all
    @colonias = Colonia.all(:order => "nombre ASC")
    @delegaciones = ["Álvaro Obregón", "Azcapotzalco", "Benito Juárez", "Coyoacán", "Cuajimalpa","Cuauhtémoc","Gustavo A. Madero","Iztacalco","Iztapalapa","Magdalena Contreras","Miguel Hidalgo","Milpa Alta","Tláhuac","Tlalpan","Venustiano Carranza","Xochimilco", "Tlalnepantla", "Tultitlán", "Cuautitlán"]
  end
  
  # GET /estaciones
  # GET /estaciones.xml
  def index
    @estaciones = Estacion.all(:order => "posicion ASC", :joins => :linea, :conditions =>  ["lineas.nombre = ?", "Linea 8: Garibaldi - Constitución de 1917"])

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @estaciones }
    end
  end

  # GET /estaciones/1
  # GET /estaciones/1.xml
  def show
    @estacion = Estacion.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @estacion }
    end
  end

  # GET /estaciones/new
  # GET /estaciones/new.xml
  def new
    @estacion = Estacion.new
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @estacion }
    end
  end

  # GET /estaciones/1/edit
  def edit
    @estacion = Estacion.find(params[:id])
  end

  # POST /estaciones
  # POST /estaciones.xml
  def create
    
    @estacion = Estacion.new(params[:estacion])
   
    params[:estacion].delete(:colonias).each do |col|
      @estacion.colonias << Colonia.find(col)
    end
    
    respond_to do |format|
      if @estacion.save
        format.html { redirect_to(@estacion, :notice => 'Estacion creada correctamente.') }
        format.xml  { render :xml => @estacion, :status => :created, :location => @estacion }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @estacion.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /estaciones/1
  # PUT /estaciones/1.xml
  def update
    @estacion = Estacion.find(params[:id])
    
    if(params[:estacion].has_key?(:colonias))
      params[:estacion].delete(:colonias).each do |col| 
        nueva_c=Colonia.find(col)
        @estacion.colonias << nueva_c unless @estacion.colonias.include?(nueva_c)
      end
    end
    
    respond_to do |format|
      if @estacion.update_attributes(params[:estacion])
        format.html { redirect_to(estaciones_url, :notice => 'Estacion actualizada correctamente.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @estacion.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /estaciones/1
  # DELETE /estaciones/1.xml
  def destroy
    @estacion = Estacion.find(params[:id])
    @estacion.destroy

    respond_to do |format|
      format.html { redirect_to(estaciones_url) }
      format.xml  { head :ok }
    end
  end
end
