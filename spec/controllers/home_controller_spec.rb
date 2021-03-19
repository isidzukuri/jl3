require 'spec_helper'

RSpec.describe HomeController do
  render_views

  describe '#index' do
    let!(:article_1) { create :article, title: 'a1' }
    let!(:article_2) { create :article, title: 'a2' }
    let!(:text_block) { create(:text_block, type: :home, related: 0) }
    let!(:meta_data) { create(:meta_data, type: :home) }
    let!(:book_1) { create :book }
    let!(:book_2) { create :book }
    let(:last_books_ids) { [book_2.id, book_1.id].join(',') }
    let!(:letter) { create :letter, symbol: 'A' }
    let!(:letter_2) { create :letter, symbol: 'B' }
    let!(:genre) { create :genre }
    let!(:genre_2) { create :genre }

    subject { get :index }

    before do
      ActiveRecord::Base.connection
                        .exec_query("INSERT INTO front_page (last) VALUES ('#{last_books_ids}');")

      subject
    end

    it do
      expect(response).to render_template(:index)
      expect(response.status).to eq 200
    end

    it 'has articles' do
      expect(response.body).to include(article_1[:title])
      expect(response.body).to include(article_1[:description])
      expect(response.body).to include(blog_path(article_1.seo_url))
      expect(response.body).to include(article_2[:title])
      expect(response.body).to include(article_2[:description])
      expect(response.body).to include(blog_path(article_2[:seo_url]))
    end

    it 'has text block' do
      expect(response.body).to include(text_block[:text])
    end

    it 'has meta tags' do
      expect(response.body).to include("<title>#{meta_data[:title]}</title>")
      expect(response.body).to include("<meta name=\"keywords\" content=\"#{meta_data[:keywords]}\" />")
      expect(response.body).to include("<meta name=\"description\" content=\"#{meta_data[:description]}\" />")
    end

    it 'has alphabet menu' do
      expect(response.body).to include("fsymbol/#{letter.id}")
      expect(response.body).to include("fsymbol/#{letter_2.id}")
    end

    it 'has genre menu' do
      expect(response.body).to include("genre/#{genre.seo_name}/page/1")
      expect(response.body).to include("genre/#{genre_2.seo_name}/page/1")
    end

    it 'has last books' do
      expect(response.body).to include(book_1[:bookname])
      expect(response.body).to include(book_path(book_1[:seo]))
      expect(response.body).to include(book_2[:bookname])
      expect(response.body).to include(book_path(book_2[:seo]))
    end
  end
end
