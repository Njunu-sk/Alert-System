FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { 'user@gmail.com' }
    password_digest { 'password' }
  end
end
