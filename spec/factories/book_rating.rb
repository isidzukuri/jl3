FactoryBot.define do
  factory :book_rating do
    rate { 5 }
    book
    user
  end
end
