class ProductsController < ApplicationController
  def new
    @product = Product.new
  end
  def create
    @product = Product.new(product_params)
    if @product.save
      flash[:notice] = 'the product has been saved'
      redirect_to @product
    else
      render :new
    end
  end

  def edit
    @product = Product.find(params[:id])

  end

  def index
    @products = Product.all
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    flash[:notice] = "Store was successfully destroyed"
    products_path
  end

  def show
    @product = Product.find(params[:id])
  end

  private
    #Never trust parametres from the sacry internet, onli allow the whie list through. seguridad, solo acepta los parametros
    def product_params
      params.require(:product).permit(:name,:reference,:precio,:quantity,:brand,:description)
    end

end
