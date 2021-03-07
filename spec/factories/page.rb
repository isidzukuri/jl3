FactoryBot.define do
  factory :page do
    name { FFaker::Product.brand }
    seo_name { FFaker::Internet.slug }
    text { FFaker::Lorem.sentence(12) }
  end
end
