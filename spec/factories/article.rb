FactoryBot.define do
  factory :article do
    title { FFaker::Product.brand }
    description { FFaker::Lorem.paragraph }
    text { FFaker::Lorem.paragraph }
    photo { 'some_file.jpg' }
    img_alt { FFaker::Lorem.words }
    img_title { FFaker::Lorem.words }
    keywords { FFaker::Lorem.words(9).join(' ') }
    meta_description { FFaker::Lorem.sentence(12) }
    date { Time.now.to_i }
    published { true }
    added_by { 'admin' }
    seo_url { FFaker::Internet.slug }
  end
end
