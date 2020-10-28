FactoryBot.define do
  factory :item do
    image                        { Faker::Lorem.sentence }
    title                        { "商品名" }
    catch_copy                   { "説明文" }
    category_id                  { 1 }
    status_id                    { 1 }
    shipping_fee_id              { 1 }
    prefecture_id                { 1 }
    delivery_date_id             { 1 }
    price                        { 12345 }
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open("public/images/test_image.png"), filename: "test_image.png")
    end
  end
end