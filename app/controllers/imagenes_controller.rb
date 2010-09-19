class ImagenesController < ApplicationController
  # GET /imagenes
  # GET /imagenes.xml
  def index
    @imagenes = Imagen.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @imagenes }
    end
  end

  # GET /imagenes/1
  # GET /imagenes/1.xml
  def show
    @imagen = Imagen.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @imagen }
      format.imagen { send_file @imagen.ruta_al_archivo, :type => @imagen.mime, :disposition => 'inline' }
    end
  end

  # GET /imagenes/new
  # GET /imagenes/new.xml
  def new
    @imagen = Imagen.new
    @categorias = Categoria.all
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @imagen }
    end
  end

  # GET /imagenes/1/edit
  def edit
    @imagen = Imagen.find(params[:id])
    @categorias = Categoria.all
  end

  # POST /imagenes
  # POST /imagenes.xml
  def create
    @imagen = Imagen.new(params[:imagen])

    respond_to do |format|
      if @imagen.save
        format.html { redirect_to(@imagen, :notice => 'Imagen was successfully created.') }
        format.xml  { render :xml => @imagen, :status => :created, :location => @imagen }
      else
        @categorias = Categoria.all
        format.html { render :action => "new" }
        format.xml  { render :xml => @imagen.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /imagenes/1
  # PUT /imagenes/1.xml
  def update
    @imagen = Imagen.find(params[:id])

    respond_to do |format|
      if @imagen.update_attributes(params[:imagen])
        format.html { redirect_to(@imagen, :notice => 'Imagen was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @imagen.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /imagenes/1
  # DELETE /imagenes/1.xml
  def destroy
    @imagen = Imagen.find(params[:id])
    @imagen.destroy

    respond_to do |format|
      format.html { redirect_to(imagenes_url) }
      format.xml  { head :ok }
    end
  end
end
