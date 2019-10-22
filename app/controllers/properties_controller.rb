class PropertiesController < ApplicationController
  # GET /properties
  def index
    # TODO
    # @properties = Dir::glob("#{Rails.root}/public/files/*.x*")
    @properties = Dir::glob("#{Rails.root}/public/files/*")
  end

  # GET /properties/new
  def new
    raise
  end

  # POST /properties
  # POST /properties.json
  def create
    @property = Property.new(property_params)

    respond_to do |format|
      if @property.save
        format.html { redirect_to @property, notice: 'Property was successfully created.' }
        format.json { render :show, status: :created, location: @property }
      else
        format.html { render :new }
        format.json { render json: @property.errors, status: :unprocessable_entity }
      end
    end
  end


  # DELETE /properties/1
  def destroy
    @property.destroy
    respond_to do |format|
      format.html { redirect_to properties_url, notice: 'Property was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # download /properties/download/:file_path
  def download
    respond_to do |format|
      format.xlsx {
        response.headers['Content-Disposition'] = "attachment; filename='#{Rails.root}/public/files/日報検索.xlsx'"
      }
    end
  end
end
