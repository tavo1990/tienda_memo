class ProductsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_product, only: [:edit ,:update, :show, :destroy]
  before_action :its_admin?
  def new
    @product = Product.new
  end
  def create
    @product = Product.new(product_params)
    if @product.save
      flash[:notice] = 'the product has been saved'
      redirect_to product_path(id: @product.id, it_was: 'created')
    else
      render :new
    end
  end

  def edit

  end

  def update

    if @product.update (product_params)
      flash[:notice] = "Store was successfully updated."
      redirect_to product_path(id: @product.id, it_was: 'updated')
    else
      render :edit
    end
  end

  def index
    @products = Product.all
  end

  def destroy

    @product.destroy
    flash[:notice] = "Store was successfully destroyed"
    redirect_to products_path
  end

  def show

    @action = params[:it_was]
  end

  private
    #Never trust parametres from the sacry internet, onli allow the whie list through. seguridad, solo acepta los parametros
    def product_params
      params.require(:product).permit(:name,:reference,:precio,:quantity,:brand,:description,:category_id,:image)
    end

    def find_product
      @product = Product.find(params[:id])
    end
    def its_admin?
      unless current_user.admin?
        redirect_to root_path, :alert => "Acceso Denegado, No posee permisos de administrador"
      end
    end

end
