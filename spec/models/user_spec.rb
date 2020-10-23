require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#create' do
    before do
      @user = FactoryBot.build(:user)
    end

    context '新規登録ができる場合' do
      it '必要事項が全て記入されていれば登録できる' do
        expect(@user).to be_valid
      end

      it 'nicknameが1文字以上で登録できる' do
        @user.nickname = 'a'
        expect(@user).to be_valid
      end

      it 'passwordが半角英数6文字以上で登録できる' do
        @user.password = 'shirosan10'
        @user.password_confirmation = @user.password
        expect(@user).to be_valid
      end

      it 'last_nameが全角混同でも登録できる' do
        @user.last_name = '白サん'
        expect(@user).to be_valid
      end

      it 'first_nameが全角混同でも登録できる' do
        @user.first_name = '太ロう'
        expect(@user).to be_valid
      end

      it 'メールアドレスに@が含まれていれば登録できる' do
        @user.email = 'text@com'
        expect(@user).to be_valid
      end
    end

    context '新規登録ができない場合' do
      it 'nicknameが空では登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end

      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end

      it 'passwordが空欄では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end

      it 'password_confirmationが空欄では登録できない' do
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it 'first_nameが空欄では登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end
      it 'first_name_kanaが空欄では登録できない' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana can't be blank")
      end
      it 'last_nameが空欄では登録できない' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name can't be blank")
      end
      it 'last_name_kanaが空欄では登録できない' do
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana can't be blank")
      end
      it 'birthdayが空欄では登録できない' do
        @user.birthday = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday can't be blank")
      end
    end

    context '空欄以外が原因で登録できない場合' do
      context 'ユーザー情報が原因の場合' do
        it '重複したemailが存在する場合登録できない' do
          @user.save
          another_user = FactoryBot.build(:user)
          another_user.email = @user.email
          another_user.valid?
          expect(another_user.errors.full_messages).to include('Email has already been taken')
        end
        it 'メールアドレスが@を含まなければ登録できない' do
          @user.email = 'EmailAddressWithoutsign'
          @user.valid?
          expect(@user.errors.full_messages).to include('Email is invalid')
        end
        it 'パスワードが5文字以下では登録できない' do
          @user.password = '00000'
          @user.password_confirmation = @user.password
          @user.valid?
          expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
        end
        it 'パスワードに半角英数字以外が含まれると登録できない' do
          @user.password = 'passワード12'
          @user.password_confirmation = @user.password
          @user.valid?
          expect(@user.errors.full_messages).to include('Password には英字と数字の両方を含めて設定してください')
        end
        it 'パスワードが半角英字だけでは登録できない' do
          @user.password = 'abcdefg'
          @user.password_confirmation = @user.password
          @user.valid?
          expect(@user.errors.full_messages).to include('Password には英字と数字の両方を含めて設定してください')
        end
        it 'パスワードが半角数字だけでは登録できない' do
          @user.password = '123456789'
          @user.password_confirmation = @user.password
          @user.valid?
          expect(@user.errors.full_messages).to include('Password には英字と数字の両方を含めて設定してください')
        end
        it 'パスワード（確認用）がパスワードと一致しなければ登録できない' do
          @user.password_confirmation += 'notequal'
          @user.valid?
          expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
        end
      end

      context '本人確認が原因のとき' do
        it "last_nameが半角では登録できない" do
          @user.last_name = "ﾀﾅｶ"
          @user.valid?
          expect(@user.errors.full_messages).to include("Last name Full-width characters.")
        end
        it "last_nameが英語では登録できない" do
          @user.last_name = "TANAKA"
          @user.valid?
          expect(@user.errors.full_messages).to include("Last name Full-width characters.")
        end
        it "last_nameが数字では登録できない" do
          @user.last_name = "4649"
          @user.valid?
          expect(@user.errors.full_messages).to include("Last name Full-width characters.")
        end
        it "first_nameが半角では登録できない" do
          @user.first_name = "ﾀﾛｳ"
          @user.valid?
          expect(@user.errors.full_messages).to include("First name Full-width characters.")
        end
        it "first_nameが英語では登録できない" do
          @user.first_name = "ＴＡＲＯ"
          @user.valid?
          expect(@user.errors.full_messages).to include("First name Full-width characters.")
        end
        it "first_nameが数字では登録できない" do
          @user.first_name = "4649"
          @user.valid?
          expect(@user.errors.full_messages).to include("First name Full-width characters.")
        end
        
        it '名（フリガナ）に半角文字が含まれると登録できない' do
          @user.first_name_kana += 'ﾀﾛｳ'
          @user.valid?
          expect(@user.errors.full_messages).to include('First name kana Full-width katakana characters.')
        end
        it '名（フリガナ）にカタカナ以外が含まれると登録できない' do
          @user.first_name_kana += 'たろう'
          @user.valid?
          expect(@user.errors.full_messages).to include('First name kana Full-width katakana characters.')
        end

        it '姓（フリガナ）に半角文字が含まれると登録できない' do
          @user.last_name_kana += 'ﾀﾅｶ'
          @user.valid?
          expect(@user.errors.full_messages).to include('Last name kana Full-width katakana characters.')
        end
        it '姓（フリガナ）にカタカナ以外が含まれると登録できない' do
          @user.last_name_kana += 'たなか'
          @user.valid?
          expect(@user.errors.full_messages).to include('Last name kana Full-width katakana characters.')
        end
      end
    end
  end
end
