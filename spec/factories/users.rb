# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    to_create {|instance| instance.save(validate: false) }
    sequence(:name) { |n| "Persons_#{n}" }
    sequence(:email)     { |n| "persons_#{n}@example.com" }
    password "12345678"
    password_confirmation "12345678"
  end
end
