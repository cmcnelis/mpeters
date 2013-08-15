#spec/factories/policies.rb

require 'faker'

FactoryGirl.define do
    factory :policy do |f|
        f.number {Faker::Number.digit}
        f.first_name {Faker::Name.first_name}
        f.last_name {Faker::Name.last_name}
        f.address {Faker::Address.street_address}
        f.city {Faker::Address.city}
        f.state{Faker::Address.state}
        f.zip_code {Faker::Address.zip_code}
 end

end

