FactoryBot.define do
  factory :meta_data do
    title { FFaker::Lorem.words.join(' ') }
    keywords { FFaker::Lorem.words(9).join(' ') }
    description { FFaker::Lorem.sentence(12) }
    type { 'page' }
    related { rand(100..1000) }
    admin_name { 'Contacts page' }

    trait :book do
      type { 'book' }
      related { 0 }
    end
  end
end
