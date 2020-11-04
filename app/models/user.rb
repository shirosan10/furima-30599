class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i.freeze
  validates_format_of :password, with: PASSWORD_REGEX, message: 'には英字と数字の両方を含めて設定してください'

  with_options presence: true do
    validates :nickname
    validates :birthday
    validates :last_name
    validates :first_name
    validates :last_name_kana
    validates :first_name_kana
  end

  NAME_REGEX = /\A[ぁ-んァ-ン一-龥]+\z/.freeze
  KANA_REGEX = /\A[ァ-ン]+\z/.freeze

  with_options format: { with: NAME_REGEX, message: 'には全角文字を使用してください' } do
    validates :first_name
    validates :last_name
  end

  with_options format: { with: KANA_REGEX, message: 'には全角カタカナを使用してください' } do
    validates :first_name_kana
    validates :last_name_kana
  end

  has_many :items
  has_many :orders
end
