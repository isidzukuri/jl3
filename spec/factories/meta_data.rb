FactoryBot.define do
  factory :meta_data do
    title { FFaker::Lorem.words }
    keywords { FFaker::Lorem.words(9) }
    description { FFaker::Lorem.sentence(12) }
    type { 'page' }
    related { rand(100..1000) }
    admin_name { 'Contacts page' }
  end
end
