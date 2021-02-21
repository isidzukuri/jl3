FactoryBot.define do
  factory :author do
    f_name { FFaker::Name.first_name }
    l_name { FFaker::Name.last_name }
    full_name { FFaker::Name.name }
    bio { FFaker::Lorem.paragraph }
  end
end
