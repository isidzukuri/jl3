require 'spec_helper'

RSpec.describe BooksController do
  render_views

  describe '#latest' do
    let!(:book_1) { create :book }
    let!(:book_2) { create :book }
    let!(:text_block) { create(:text_block, type: :latest_incomes, related: 0) }
    let!(:meta_data) { create(:meta_data, type: :latest_incomes, related: 0) }

    subject! { get :latest }

    it do
      expect(response).to render_template(:latest)
      expect(response.status).to eq 200
    end

    it 'has books' do
      expect(response.body).to include(book_1[:bookname])
      expect(response.body).to include(book_path(book_1[:seo]))
      expect(response.body).to include(book_2[:bookname])
      expect(response.body).to include(book_path(book_2[:seo]))
    end

    it 'has meta tags' do
      expect(response.body).to include("<title>#{meta_data[:title]}</title>")
      expect(response.body).to include("<meta name=\"keywords\" content=\"#{meta_data[:keywords]}\" />")
      expect(response.body).to include("<meta name=\"description\" content=\"#{meta_data[:description]}\" />")
    end
    
    it 'has text' do
      expect(response.body).to include("<h2>#{meta_data[:title]}</h2>")
      expect(response.body).to include(text_block[:text])
    end
  end
end
