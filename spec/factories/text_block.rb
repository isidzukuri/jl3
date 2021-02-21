FactoryBot.define do
  factory :text_block do
    title { FFaker::Lorem.words }
    text { FFaker::Lorem.paragraph }
    type { 'page' }
    related { rand(100..1000) }
  end
end
