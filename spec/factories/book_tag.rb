FactoryBot.define do
  factory :book_tag do
    moderated { true }
    book
    tag
  end
end
