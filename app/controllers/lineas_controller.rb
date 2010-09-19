class LineasController < ApplicationController
  
  before_filter :colecciones_a_usar, :except => [:index, :show, :destroy]

   def colecciones_a_usar
     @transportes = Transporte.all
   end
   
  # GET /lineas
  # GET /lineas.xml
  def index
    @lineas = Linea.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @lineas }
    end
  end

  # GET /lineas/1
  # GET /lineas/1.xml
  def show
    @linea = Linea.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @linea }
    end
  end

  # GET /lineas/new
  # GET /lineas/new.xml
  def new
    @linea = Linea.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @linea }
    end
  end

  # GET /lineas/1/edit
  def edit
    @linea = Linea.find(params[:id])
  end

  # POST /lineas
  # POST /lineas.xml
  def create
    @linea = Linea.new(params[:linea])

    respond_to do |format|
      if @linea.save
        format.html { redirect_to(@linea, :notice => 'Linea creada correctamente.') }
        format.xml  { render :xml => @linea, :status => :created, :location => @linea }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @linea.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /lineas/1
  # PUT /lineas/1.xml
  def update
    @linea = Linea.find(params[:id])

    respond_to do |format|
      if @linea.update_attributes(params[:linea])
        format.html { redirect_to(@linea, :notice => 'Linea actualizada correctamente.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @linea.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /lineas/1
  # DELETE /lineas/1.xml
  def destroy
    @linea = Linea.find(params[:id])
    @linea.destroy

    respond_to do |format|
      format.html { redirect_to(lineas_url) }
      format.xml  { head :ok }
    end
  end
end
