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

    # genres
    # first letters
    # books
  end
end
