class DlesController < ApplicationController
  # GET /dles
  # GET /dles.xml
  def index
    @dles = Dle.find(:all, :order => [:amanda_config_id, :host, :disk])

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @dles }
    end
  end

  # GET /dles/1
  # GET /dles/1.xml
  def show
    @dle = Dle.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @dle }
    end
  end

  # GET /dles/new
  # GET /dles/new.xml
  def new
    @dle = Dle.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @dle }
    end
  end

  # GET /dles/1/edit
  def edit
    @dle = Dle.find(params[:id])
  end

  # POST /dles
  # POST /dles.xml
  def create
    @dle = Dle.new(params[:dle])

    respond_to do |format|
      if @dle.save
        format.html { redirect_to(@dle, :notice => 'Dle was successfully created.') }
        format.xml  { render :xml => @dle, :status => :created, :location => @dle }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @dle.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /dles/1
  # PUT /dles/1.xml
  def update
    @dle = Dle.find(params[:id])

    respond_to do |format|
      if @dle.update_attributes(params[:dle])
        format.html { redirect_to(@dle, :notice => 'Dle was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @dle.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /dles/1
  # DELETE /dles/1.xml
  def destroy
    @dle = Dle.find(params[:id])
    @dle.destroy

    respond_to do |format|
      format.html { redirect_to(dles_url) }
      format.xml  { head :ok }
    end
  end
end
