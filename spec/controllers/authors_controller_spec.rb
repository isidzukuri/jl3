require 'spec_helper'

RSpec.describe AuthorsController do
  render_views

  describe '#show' do
    let!(:author) { create :author }
    let!(:author_2) { create :author }
    let!(:book_1) { create :book, bookname: 'A', author: author }
    let!(:book_2) { create :book, bookname: 'A', author: author_2 }
    let!(:books) { create_list :book, 100, bookname: 'B', author: author }
    let!(:text_block) { create(:text_block, type: :author, related: 0) }

    subject! { get :show, params: { id: author.id } }

    it do
      expect(response).to render_template(:show)
      expect(response.status).to eq 200
    end

    it 'has books' do
      expect(response.body).to include(author[:full_name])
      expect(response.body).to include(book_1[:bookname])
      expect(response.body).to include(book_path(book_1[:seo]))
      expect(response.body).not_to include(book_path(book_2[:seo]))
    end

    it 'has meta tags' do
      expect(response.body).to include("<title>#{author.full_name}")
      expect(response.body).to include("<meta name=\"keywords\" content=\"#{author.full_name}")
      expect(response.body).to include("<meta name=\"description\" content=\"#{author.full_name}")
    end

    it 'has paginator' do
      expect(response.body).to include(I18n.t(:go_to_page))
      expect(response.body).to include("author/#{author.id}?page=2")
    end
  end

  describe '#bio' do
    let!(:author) { create :author }
    let!(:author_2) { create :author }
    let!(:book_1) { create :book, bookname: 'A', author: author }
    let!(:book_2) { create :book, bookname: 'A', author: author_2 }
    let!(:books) { create_list :book, 100, bookname: 'B', author: author }
    let!(:text_block) { create(:text_block, type: :author, related: 0) }

    subject! { get :bio, params: { id: author.id } }

    it do
      expect(response).to render_template(:bio)
      expect(response.status).to eq 200
    end

    it 'has books' do
      expect(response.body).to include(author[:bio])
      expect(response.body).to include(author[:full_name])
      expect(response.body).to include(book_1[:bookname])
      expect(response.body).to include(book_path(book_1[:seo]))
      expect(response.body).not_to include(book_path(book_2[:seo]))
    end

    it 'has meta tags' do
      expect(response.body).to include("<title>#{author.full_name}")
      expect(response.body).to include("<meta name=\"keywords\" content=\"#{author.full_name}")
      expect(response.body).to include("<meta name=\"description\" content=\"#{author.full_name}")
    end

    it 'has paginator' do
      expect(response.body).to include(I18n.t(:go_to_page))
      expect(response.body).to include("author/bio/#{author.id}?page=2")
    end
  end
end
