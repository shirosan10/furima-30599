FactoryBot.define do
  factory :Item_order do
    token             { 'tok_abcdefghijk00000000000000000' }
    postal_code       { '123-4567' }
    prefecture_id     { 1 }
    city              { '東京都' }
    line              { '1-1' }
    building_room     { '東京ハイツ' }
    phone_number      { '09012345678' }
  end
end
