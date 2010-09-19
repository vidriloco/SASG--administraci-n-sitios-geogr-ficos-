class ColoniasController < ApplicationController
  # GET /colonias
  # GET /colonias.xml
  def index
    @colonias = Colonia.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @colonias }
    end
  end

  # GET /colonias/1
  # GET /colonias/1.xml
  def show
    @colonia = Colonia.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @colonia }
    end
  end

  # GET /colonias/new
  # GET /colonias/new.xml
  def new
    @colonia = Colonia.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @colonia }
    end
  end

  # GET /colonias/1/edit
  def edit
    @colonia = Colonia.find(params[:id])
  end

  # POST /colonias
  # POST /colonias.xml
  def create
    @colonia = Colonia.new(params[:colonia])

    respond_to do |format|
      if @colonia.save
        format.html { redirect_to(@colonia, :notice => 'Colonia creada correctamente.') }
        format.xml  { render :xml => @colonia, :status => :created, :location => @colonia }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @colonia.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /colonias/1
  # PUT /colonias/1.xml
  def update
    @colonia = Colonia.find(params[:id])

    respond_to do |format|
      if @colonia.update_attributes(params[:colonia])
        format.html { redirect_to(@colonia, :notice => 'Colonia actualizada correctamente.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @colonia.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /colonias/1
  # DELETE /colonias/1.xml
  def destroy
    @colonia = Colonia.find(params[:id])
    @colonia.destroy

    respond_to do |format|
      format.html { redirect_to(colonias_url) }
      format.xml  { head :ok }
    end
  end
end
