require 'spec_helper'

RSpec.describe GenresController do
  render_views

  describe '#show' do
    let!(:genre) { create :genre }
    let!(:genre_2) { create :genre }
    let!(:book_1) { create :book, bookname: 'A', genre: genre }
    let!(:book_2) { create :book, bookname: 'A', genre: genre_2 }
    let!(:books) { create_list :book, 100, bookname: 'B', genre: genre }
    let!(:text_block) { create(:text_block, type: :genre, related: 0) }

    subject! { get :show, params: { id: genre.id } }

    it do
      expect(response).to render_template(:show)
      expect(response.status).to eq 200
    end

    it 'has books' do
      expect(response.body).to include(book_1[:bookname])
      expect(response.body).to include(book_path(book_1[:seo]))
      expect(response.body).not_to include(book_path(book_2[:seo]))
    end

    it 'has meta tags' do
      expect(response.body).to include("<title>#{I18n.t(:default_title)}")
      expect(response.body).to include("<meta name=\"keywords\" content=\"#{I18n.t(:default_keywords)}")
      expect(response.body).to include("<meta name=\"description\" content=\"#{I18n.t(:default_description)}")
    end

    it 'has paginator' do
      expect(response.body).to include(I18n.t(:go_to_page))
      expect(response.body).to include("genre/#{genre.id}/page/2")
    end
  end
end
