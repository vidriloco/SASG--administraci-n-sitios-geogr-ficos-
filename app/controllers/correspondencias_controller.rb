# coding: utf-8
class CorrespondenciasController < ApplicationController
  # GET /correspondencias
  # GET /correspondencias.xml
  def index
    @correspondencias = Correspondencia.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @correspondencias }
    end
  end

  # GET /correspondencias/1
  # GET /correspondencias/1.xml
  def show
    @correspondencia = Correspondencia.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @correspondencia }
    end
  end

  # GET /correspondencias/new
  # GET /correspondencias/new.xml
  def new
    @correspondencia = Correspondencia.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @correspondencia }
    end
  end

  # GET /correspondencias/1/edit
  def edit
    @correspondencia = Correspondencia.find(params[:id])
  end

  # POST /correspondencias
  # POST /correspondencias.xml
  def create
    @correspondencia = Correspondencia.new(params[:correspondencia])

    respond_to do |format|
      if @correspondencia.save
        format.html { redirect_to(@correspondencia, :notice => 'Correspondencia fue creada con éxito.') }
        format.xml  { render :xml => @correspondencia, :status => :created, :location => @correspondencia }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @correspondencia.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /correspondencias/1
  # PUT /correspondencias/1.xml
  def update
    @correspondencia = Correspondencia.find(params[:id])

    respond_to do |format|
      if @correspondencia.update_attributes(params[:correspondencia])
        format.html { redirect_to(@correspondencia, :notice => 'Correspondencia fue actualizada.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @correspondencia.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /correspondencias/1
  # DELETE /correspondencias/1.xml
  def destroy
    @correspondencia = Correspondencia.find(params[:id])
    @correspondencia.destroy

    respond_to do |format|
      format.html { redirect_to(correspondencias_url) }
      format.xml  { head :ok }
    end
  end
end
