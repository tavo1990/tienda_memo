class CategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_product, only: [:show,:edit,:update,:destroy]
  before_action :its_admin?
  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:notice] = 'The Category has been saved'
      redirect_to category_path(id: @category.id, it_was: 'created')
    else
      render :new
    end
  end

  def update
    if @category.update (category_params)
      flash[:notice] = 'The Category has been Modified'
      redirect_to category_path(id: @category.id, it_was: 'modified')
    else
      render :edit
    end
  end

  def edit
  end

  def index
    @categories = Category.all
  end

  def destroy
    @category.destroy
    flash[:notice] = "Category was successfully destroyed"
    redirect_to categories_path
  end

  def show
    @action = params[:it_was]
  end
  private
    #Never trust parametres from the sacry internet, onli allow the whie list through. seguridad, solo acepta los parametros
    def category_params
      params.require(:category).permit(:name,:description)
    end

    def find_product
      @category = Category.find(params[:id])
    end
    def its_admin?
      unless current_user.admin?
        redirect_to root_path, :alert => "Acceso Denegado, No posee permisos de administrador"
      end
    end
end
