require 'spec_helper'

RSpec.describe :test do
  it {
    create(:book)
    create(:author)
    create(:book_rating)
    create(:book_support)
    create(:book_tag)
    create(:genre)
    create(:meta_data)
    create(:tag)
    create(:text_block)
    create(:user)
  }
end
