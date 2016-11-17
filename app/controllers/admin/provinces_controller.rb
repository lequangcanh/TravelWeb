class Admin::ProvincesController < Admin::BaseController

  def index
    @provinces = params[:search]present? ? Province.search(params[:search]).paginate(page: params[:page]) : Province.paginate(page: params[:page])
  end

  def new
    @province = Province.new
  end

  def create
    @province = Province.create(province_params)
    if @province.save
      flash[:success] = "Created successfull"
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
      flash[:success] = "Updated successfull"
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
    flash[:success] = "Delete successfull"
    redirect_to admin_provinces_path
  end

  private
  def province_params
    params.require(:province).permit(:name, :description)
  end
end
