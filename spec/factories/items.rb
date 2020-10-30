FactoryBot.define do
  factory :item do
    image                        { Faker::Lorem.sentence }
    title                        { '商品名' }
    catch_copy                   { '説明文' }
    category_id                  { 2 }
    status_id                    { 2 }
    shipping_fee_id              { 2 }
    prefecture_id                { 2 }
    delivery_date_id             { 2 }
    price                        { 1000 }
    association :user
  end
end
