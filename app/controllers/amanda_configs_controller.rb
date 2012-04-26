class AmandaConfigsController < ApplicationController
  # GET /amanda_configs
  # GET /amanda_configs.xml
  def index
    @amanda_configs = AmandaConfig.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @amanda_configs }
    end
  end

  # GET /amanda_configs/1
  # GET /amanda_configs/1.xml
  def show
    @amanda_config = AmandaConfig.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @amanda_config }
    end
  end

  # GET /amanda_configs/new
  # GET /amanda_configs/new.xml
  def new
    @amanda_config = AmandaConfig.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @amanda_config }
    end
  end

  # GET /amanda_configs/1/edit
  def edit
    @amanda_config = AmandaConfig.find(params[:id])
  end

  # POST /amanda_configs
  # POST /amanda_configs.xml
  def create
    @amanda_config = AmandaConfig.new(params[:amanda_config])

    respond_to do |format|
      if @amanda_config.save
        format.html { redirect_to(@amanda_config, :notice => 'Amanda config was successfully created.') }
        format.xml  { render :xml => @amanda_config, :status => :created, :location => @amanda_config }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @amanda_config.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /amanda_configs/1
  # PUT /amanda_configs/1.xml
  def update
    @amanda_config = AmandaConfig.find(params[:id])

    respond_to do |format|
      if @amanda_config.update_attributes(params[:amanda_config])
        format.html { redirect_to(@amanda_config, :notice => 'Amanda config was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @amanda_config.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /amanda_configs/1
  # DELETE /amanda_configs/1.xml
  def destroy
    @amanda_config = AmandaConfig.find(params[:id])
    @amanda_config.destroy

    respond_to do |format|
      format.html { redirect_to(amanda_configs_url) }
      format.xml  { head :ok }
    end
  end
end
