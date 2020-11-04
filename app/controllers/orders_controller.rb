class OrdersController < ApplicationController
  def new
    @order = Order.new
  end

  def index
    @item_order = ItemOrder.new
  end

  def create

    @item_order = ItemOrder.new(order_params)
    if @item_order.valid?
      @item_order.save
      redirect_to root_path
    else
      render action: :index
    end
  end

  private
  def order_params
    params.require(:item_order).permit(:postal_code, :prefecture_id, :city, :line, :building_room, :phone_number).merge(token: params[:token])
  end

  

end
