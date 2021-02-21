FactoryBot.define do
  factory :genre do
    name { FFaker::Book.genre }
    seo_name { FFaker::Internet.slug }
  end
end
