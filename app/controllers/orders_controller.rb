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
      pay_item
      @item_order.save
      redirect_to root_path
    else
      render :index
    end
  end

  private
  def order_params
    params.require(:item_order).permit(:token, :postal_code, :prefecture_id, :city, :line, :building_room, :phone_number).merge(user_id: current_user.id)
  end

  def item_params
    params.require(:item).permit(:title, :price).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: @item.price,
      card: order_params[:token],
      currency: 'jpy'
    )
  end

end
