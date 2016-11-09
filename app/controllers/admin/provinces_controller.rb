class Admin::ProvincesController < ApplicationController
  layout 'admin/layouts/admin_panel'

  def index
    @provinces = Province.all
  end

  def new
    @province = Province.new
  end

  def create
    @province = Province.create(province_params)
    if @province.save
      redirect_to admin_provinces_path
    else
      render 'new'
    end
  end

  def edit
    @province = Province.find(params[:id])
  end

  def update
    @province = Province.find(params[:id])
    if @province.update_attributes(province_params)
      redirect_to admin_province_path(@province)
	else
	  render 'edit'
    end
  end

  def show
    @province = Province.find_by(id: params[:id])
  end

  def destroy
    Province.find(params[:id]).destroy
    redirect_to admin_provinces_path
  end

  private
  def province_params
    params.require(:province).permit(:name, :description)
  end
end
