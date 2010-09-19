class SitiosController < ApplicationController
  # GET /sitios
  # GET /sitios.xml
  def index
    # Evitamos mostrar los 10000 registros
    @sitios = Sitio.find(:all, :limit => 10)
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @sitios }
    end
  end
  
  # GET /sitios.xml
  def index_by
    # cc => "-99.2932323, 19.34323" , :ce => "-99.3224234, 19.233442"
    # Extraer información - de las dos coordenadas para conocer el radio - del 'id'
    cc = params[:cc].split(",")
    ce = params[:ce].split(",")
    cats = params[:categorias].split(",")
    centro = Point.from_lon_lat(cc[0].to_f, cc[1].to_f, 4326)
    extremo = Point.from_lon_lat(ce[0].to_f, ce[1].to_f, 4326)
    radio = centro.euclidian_distance(extremo)
    @sitios = Sitio.encuentra_dentro_de_radio(centro, radio, cats)
    respond_to do |format|
      format.xml { render :xml => @sitios }
    end
  end
  
  def busca_sitios
  end

  # GET /sitios/1
  # GET /sitios/1.xml
  def show
    @sitio = Sitio.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @sitio }
    end
  end

  # GET /sitios/new
  # GET /sitios/new.xml
  def new
    @sitio = Sitio.new
    @categorias = Categoria.all

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @sitio }
    end
  end

  # GET /sitios/1/edit
  def edit
    @sitio = Sitio.find(params[:id])
    @categorias = Categoria.all
  end

  # POST /sitios
  # POST /sitios.xml
  def create
    @sitio = Sitio.new(params[:sitio])

    respond_to do |format|
      if @sitio.save
        format.html { redirect_to(@sitio, :notice => 'Sitio was successfully created.') }
        format.xml  { render :xml => @sitio, :status => :created, :location => @sitio }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @sitio.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /sitios/1
  # PUT /sitios/1.xml
  def update
    @sitio = Sitio.find(params[:id])

    respond_to do |format|
      if @sitio.update_attributes(params[:sitio])
        format.html { redirect_to(@sitio, :notice => 'Sitio was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @sitio.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /sitios/1
  # DELETE /sitios/1.xml
  def destroy
    @sitio = Sitio.find(params[:id])
    @sitio.destroy

    respond_to do |format|
      format.html { redirect_to(sitios_url) }
      format.xml  { head :ok }
    end
  end
end
