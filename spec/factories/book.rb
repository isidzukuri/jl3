FactoryBot.define do
  factory :book do
    authorid { 1 }
    genre { 1 }
    bookname { FFaker::Book.title }
    bookdescribe { FFaker::Book.description }
    txtfile { '' }
    # paper { FFaker::Internet.http_url }
    # txt { FFaker::Internet.http_url }
    # rtf { FFaker::Internet.http_url }
    # doc { FFaker::Internet.http_url }
    # pdf { FFaker::Internet.http_url }
    # fb2 { FFaker::Internet.http_url }
    # epub { FFaker::Internet.http_url }
    # mobi { FFaker::Internet.http_url }
    # djvu { FFaker::Internet.http_url }

    # genre { create(:genre) }
    # authors { [create(:author)] }
  end
end
