require 'rails_helper'

RSpec.describe Item, type: :model do
  before '#create' do
    @item = FactoryBot.build(:item)
    @item.image = fixture_file_upload('app/assets/images/camera.png')
  end

  describe '商品出品機能' do
    context '商品出品がうまくいく場合' do
      it '入力必須項目を全て記入すれば出品できる' do
        expect(@item).to be_valid
      end
    end

    context '商品出品がうまくいかない場合' do
      it '商品名が空だと登録できない' do
        @item.title = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Title can't be blank")
      end
      it '商品の説明がないと登録できない' do
        @item.catch_copy = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Catch copy can't be blank")
      end
      it 'カテゴリーの情報がないと登録できない' do
        @item.category_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include('Category Select')
      end
      it '商品の状態についての情報がないと登録できない' do
        @item.status_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include('Status Select')
      end
      it '配送料の負担についての情報がないと登録できない' do
        @item.shipping_fee_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include('Shipping fee Select')
      end
      it '発送元の地域についての情報がないと登録できない' do
        @item.prefecture_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include('Prefecture Select')
      end
      it '発送までの日数についての情報がないと登録できない' do
        @item.delivery_date_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include('Delivery date Select')
      end
      it '価格についての情報がないと登録できない' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end
      it '価格が¥300以下だと登録できない' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is out of setting range')
      end
      it '金額が10,000,000円以上だと登録できない' do
        @item.price = 10_000_000
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is out of setting range')
      end
      it '販売価格が全角数字だと登録できない' do
        @item.price = '１２３４５'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is out of setting range')
      end
    end
  end
end
