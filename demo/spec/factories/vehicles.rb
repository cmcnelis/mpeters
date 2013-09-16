#spec/factories/vehicles.rb

require 'faker'

FactoryGirl.define do
    factory :vehicle do |f|
        f.vin{Faker::Number.digit}
        f.start_date{Date.today}
        f.expr_date{Date.today + 1.year}
        f.make{Faker::Company.name}
        f.model{Faker::Commerce.product_name}
        f.color{Faker::Commerce.color}
        f.deductible{Faker::Number.digit}
    end
end

