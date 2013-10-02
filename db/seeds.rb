# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

vehicles = Vehicle.create!([
    {
        :vin=>'A1234567890123456',
        :make=>'Chevy',
        :model=>'Tahoe',
        :color=>"Black",
        :deductible=>"500",
        :previous_deductible=>"500",
        :drivers=>'John Doe, Jane Doe'},

    {
        :vin=>"B1234567890123456",
        :make=>"Subaru",
        :model=>"Wrx",
        :color=>'Blue',
        :deductible=>'500',
        :previous_deductible=>'500',
        :drivers=>'John Doe, Jane Doe'

    }
]) #end vehicle.create

policies = Policy.create!([
    {
        :number=>'123456789-1',
        :first_name=>'John',
        :last_name=>'Doe',
        :address=>'123 Street',
        :city=>'Austin',
        :state=>'TX',
        :zip_code=>'12345',
        :email=>'johndoe@email.com'
        :email_confirmation=>'johndoe@email.com'
    }
])

agent = Agent.create!(
        :first_name=>'Bill',
        :last_name=>'Smith',
        :company=>'Farmers',
        :email=>'bsmith@email.com',
        :password=>'password',
        :password_confirmation=>'password'
        )

vehicles.each do |v|
    policies.first.vehicles<<v
end

agent.policies<<policies.first
