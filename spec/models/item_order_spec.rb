require 'rails_helper'

RSpec.describe ItemOrder, type: :model do
  describe "商品注文情報の保存" do
    before do
      @Item_order = FactoryBot.build(:item_order)
    end
    
    it "必要事項が全て記入されていれば購入できる" do
      expect(@Item_order).to be_valid
    end

    it "建物名が抜けていても購入できる" do
      @item_order.building_name = nil
      expect(@item_order).to be_valid
    end

    
    it "カード情報が空だと購入できない" do
      @item_order.token = nil
      @item_order.valid?
      expect(@item_order.errors.full_messages).to include("Token can't be blank")
    end

    it "郵便番号が空だと購入できない" do
      @item_order.postal_code = nil
      @item_order.valid?
      expect(@item_order.errors.full_messages).to include("Postal code can't be blank")
    end

    it "郵便番号が全角数字だと購入できない" do
      @item_order.postal_code = "１２３４５６７"
      @item_order.valid?
      expect(@item_order.errors.full_messages).to include("Postal code is invalid")
    end

    it "郵便番号の-が抜けていると購入できない" do
      @item_order.postal_code = "1234567"
      @item_order.valid?
      expect(@item_order.errors.full_messages).to include("Postal code is invalid")
    end

    it "都道府県が--だと購入できない" do
      @item_order.prefecture_id = "---"
      @item_order.valid?
      expect(@item_order.errors.full_messages).to include("Prefecture is not a number")
    end

    it "市区町村が空だと購入できない" do
      @item_order.city = nil
      @item_order.valid?
      expect(@item_order.errors.full_messages).to include("City can't be blank")
    end

    it "番地が空だと購入できない" do
      @item_order.line = nil
      @item_order.valid?
      expect(@item_order.errors.full_messages).to include("House number can't be blank")
    end

    it "電話番号が空だと購入できない" do
      @item_order.phone_number = nil
      @item_order.valid?
      expect(@item_order.errors.full_messages).to include("Phone number can't be blank")
    end

    it "電話番号が全角数字だと購入できない" do
      @item_order.tell_number = "０7０１２３４５６７８"
      @item_order.valid?
      expect(@item_order.errors.full_messages).to include("Tell number is invalid")
    end
  end
end