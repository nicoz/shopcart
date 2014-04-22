class ItemInstancesController < ApplicationController
    before_action :signed_in_user
    before_action :is_admin
    
    before_action :keep_location, only: [:index, :show]
    
    def index
      @item = Item.by_name(params[:item])
      unless @item.nil?
        @lines = ItemInstance.joins(item_version: :item).where('items.active=?', true).where('items.id=?', @item.id).where(active: params[:inactive] != 'on').paginate(page: params[:page])
        
        @title = "Administracion de #{@item.name.pluralize}"
        render layout: 'desktop'
      else
        redirect_back_or administrators_path
      end
      
      
    end
    
    def multi_index
      @title = "Administracion de Articulos"
      render layout: 'desktop'
    end
    
    def new
      @item = Item.by_name(params[:item])
      @item_version = @item.current_version
      unless @item.nil?
        @title = "Crear #{@item.name}"
        @item_instance = ItemInstance.new(item_version_id: @item_version.id)
        @item_instance_version = @item_instance.new_version()
        render layout: 'desktop'
      else
        redirect_back_or administrators_path
      end
    end
    
    def create
      
      @item = Item.by_name(params[:item])
      @item_version = @item.current_version
      unless @item.nil?
        @title = "Crear #{@item.name}"
        @item_instance = ItemInstance.create!(item_version_id: @item_version.id)
        
        @item_instance_version = ItemInstanceVersion.new(item_instance_version_params)
        @item_instance_version.item_instance = @item_instance
        
        if @item_instance_version.save
          redirect_back_or administrators_path
        else
          render 'new', layout: 'desktop'
        end
      else
        redirect_back_or administrators_path
      end
    end
    
    def show
      @item = Item.by_name(params[:item])
      @item_version = @item.current_version
      
      @item_instance = ItemInstance.where(item_version_id: @item_version.id).first
      @current_version = ItemInstanceVersion.where(id: params[:id]).first
      @title = "Detalles del #{@item.name}: #{@current_version.value(act_as: 'principal').value}"
      render layout: 'desktop'
    end
    
    def edit
      @item = Item.by_name(params[:item])
      @item_version = @item.current_version
      
      @item_instance = ItemInstance.where(item_version_id: @item_version.id).first
      @current_version = ItemInstanceVersion.where(id: params[:id]).first
      @item_instance_version = @item_instance.clone_version(@current_version)
      render layout: 'desktop'
    end
    
    def update
      @item = Item.by_name(params[:item])
      @item_version = @item.current_version
      
      @item_instance = ItemInstance.where(item_version_id: @item_version.id).first
      unless @item.nil?
        @title = "Editar #{@item.name}"
        @current_version = ItemInstanceVersion.where(id: params[:id]).first
        @item_instance = @current_version.item_instance
        
        @item_instance_version = ItemInstanceVersion.new(item_instance_version_params)
        @item_instance_version.item_instance = @item_instance
        
        if @item_instance_version.save
          redirect_back_or administrators_path
        else
          render 'edit', layout: 'desktop'
        end
      else
        redirect_back_or administrators_path
      end
    end
    
    def destroy
      @item = Item.by_name(params[:item])
      @item_version = @item.current_version
      @current_version = ItemInstanceVersion.where(id: params[:id]).first
      @item_instance = @current_version.item_instance
      if @item_instance.destroy
        flash[:success] = 'Registro eliminado correctamente'
      else
        flash[:warning] = 'No se pudo eliminar el registro' 
      end
      redirect_back_or administrators_path
    end
    
    def activate
      @item = Item.by_name(params[:item])
      @item_version = @item.current_version
      @current_version = ItemInstanceVersion.where(id: params[:id]).first
      @item_instance = @current_version.item_instance
      if @item_instance.activate
        flash[:success] = 'Registro activado correctamente'
      else
        flash[:warning] = 'No se pudo activar el registro' 
      end
      redirect_back_or administrators_path
    end
    
  private
    def item_instance_params
      params.require(:item_instance).permit(:all)
    end
    
    def item_instance_version_params
      params.require(:item_instance_version).permit(:item_instance_id,
        item_instance_version_values_attributes: [:value, :image, :image_cache, :item_field_id])
    end
end
