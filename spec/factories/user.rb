FactoryBot.define do
  factory :user do
    username { FFaker::Internet.user_name }
    password { FFaker::Internet.password }
    email { FFaker::Internet.email }
    last_login { Time.now.to_i }
  end
end
