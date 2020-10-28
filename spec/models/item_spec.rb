require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
    @item.image = fixture_file_upload('app/assets/images/camera.png')
  end

  describe "商品出品機能" do
    context "商品出品がうまくいく場合" do
      it "入力必須項目を全て記入すれば出品できる" do
        expect(@item).to be_valid
      end
    end

    context "商品出品がうまくいかない場合" do
      it "商品名が空だと登録できない" do
        @item.title = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("Name can't be blank")
      end
      it "商品の説明がないと登録できない" do
        @item.catch_copy = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("Introduction can't be blank")
      end
      it "カテゴリーの情報がないと登録できない" do
        @item.category_id = "1"
        @item.valid?
        expect(@item.errors.full_messages).to include("Category must be other than 1")
      end
      it "商品の状態についての情報がないと登録できない" do
        @item.status_id = "1"
        @item.valid?
        expect(@item.errors.full_messages).to include("Item condition must be other than 1")
      end
      it "配送料の負担についての情報がないと登録できない" do
        @item.shipping_fee_id = "1"
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping charge must be other than 1")
      end
      it "発送元の地域についての情報がないと登録できない" do
        @item.prefecture_id = "1"
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping area must be other than 1")
      end
      it "発送までの日数についての情報がないと登録できない" do
        @item.delivery_date_id = "1"
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping date must be other than 1")
      end
      it "価格についての情報がないと登録できない" do
        @item.price = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end
      it "価格が¥300以下だと登録できない" do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is out of setting range")
      end
      it "金額が10,000,000円以上だと登録できない" do
        @item.price = 10000000
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is out of setting range")
      end
      it "販売価格が全角数字だと登録できない" do
        @item.price = "１２３４５"
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is not a number")
      end
    end
  end
end
