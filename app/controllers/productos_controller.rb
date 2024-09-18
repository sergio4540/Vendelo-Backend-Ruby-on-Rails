class ProductosController < ApplicationController
    protect_from_forgery with: :null_session, if: -> { request.format.json? }
    before_action :set_producto, only: %i[show update destroy]
    before_action :authenticate
  
    # GET /productos
    def index
      @productos = Producto.all
      render json: @productos
    end
  
    # GET /productos/1
    def show
      render json: @producto
    end
  
    # POST /productos
    def create
      @producto = Producto.new(producto_params)
  
      if @producto.save
        render json: @producto, status: :created, location: @producto
      else
        render json: @producto.errors, status: :unprocessable_entity
      end
    end
  
    # PATCH/PUT /productos/1
    def update
      if @producto.update(producto_params)
        render json: @producto
      else
        render json: @producto.errors, status: :unprocessable_entity
      end
    end
  
    # DELETE /productos/1
    def destroy
      @producto.destroy
    end
  
    private
  
    # Use callbacks to share common setup or constraints between actions.
    def set_producto
      @producto = Producto.find(params[:id])
    end
  
    # Only allow a list of trusted parameters through.
    def producto_params
      params.require(:producto).permit(:nombre, :descripcion, :precio)
    end
  
    # Basic authentication
    def authenticate
      authenticate_or_request_with_http_basic do |username, password|
        username == ENV['API_USERNAME'] && password == ENV['API_PASSWORD']
      end
    end
  end
  