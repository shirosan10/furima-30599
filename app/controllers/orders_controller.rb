class OrdersController < ApplicationController
  before_action :set_item, only:[:index, :create]
  before_action :authenticate_user!, only: [:index]

  def index
    if current_user.id == @item.user_id || @item.order
      redirect_to root_path 
    end
    @item_order = ItemOrder.new
  end

  def create

    @item_order = ItemOrder.new(order_params)
    if @item_order.valid?
      @item_order.save
      redirect_to root_path
    else
      @item = Item.find(params[:item_id])
      render :index
    end
  end

  private
  def order_params
    params.require(:item_order).permit(:postal_code, :prefecture_id, :city, :line, :building_room, :phone_number).merge(token: params[:token])
  end

  def item_params
    params.require(:item).permit(:title, :price,).merge(user_id: current_user.id)
  end

end
