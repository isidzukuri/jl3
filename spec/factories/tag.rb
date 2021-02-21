FactoryBot.define do
  factory :tag do
    title { FFaker::Product.brand }
    seo_url { FFaker::Internet.slug }
  end
end
