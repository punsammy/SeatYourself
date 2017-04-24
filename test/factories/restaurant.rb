FactoryGirl.define do

  factory :restaurant do
    name      { ['Swiss Chalet', 'Burger Priest', 'Shawarma King'].sample }
    address   { ['22 King St', '44 yonge St', '92 Queen St'].sample }
    capacity  { rand(5..100) }
    phone_number { "(416)-555-#{rand(1000..10000)}" }
    description  { "This is a fake restaurant!" }
    user_id      { 0 }
    opening_time { Restaurant.default_opening_time }
    closing_time { Restaurant.default_closing_time }
    special { "" }
  end

end
