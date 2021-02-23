FactoryBot.define do
  factory :text_block do
    title { FFaker::Lorem.words }
    text { FFaker::Lorem.paragraph }
    type { 'page' }
    related { rand(100..1000) }

    trait :book do
      type { 'book' }
      related { 0 }
    end
  end
end
