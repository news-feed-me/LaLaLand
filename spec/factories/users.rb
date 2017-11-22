require 'securerandom'

randomstring = SecureRandom.hex(5)
FactoryGirl.define do
  factory :user do
    first_name  { Faker::Name.first_name}
    last_name {Faker::Name.last_name}
    #user_name {Faker::Hipster.word}
    user_name{Faker::Internet.user_name(5..15)}
    password {Array.new(8){[*"A".."Z", *"0".."9"].sample}.join}
    email {Faker::Internet.email}
    birth_date {}


  end
end
