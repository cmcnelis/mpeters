# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :transaction do
    amount 1
    pp_id "MyString"
    approved false
    vehicle nil
    address "MyString"
    city "MyString"
    zip_code "MyString"
    card_number "MyString"
    card_type "MyString"
    csc "MyString"
    exp "MyString"
    first_name "MyString"
    last_name "MyString"
  end
end
