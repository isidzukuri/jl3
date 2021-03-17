require 'spec_helper'

RSpec.describe BlogController do
  render_views

  describe '#index' do
    let!(:articles) { create_list :article, 10 }
    let!(:article_1) { create :article, title: 'a1' }
    let!(:article_2) { create :article, title: 'a2' }
    let!(:meta_data) { create(:meta_data, type: :blog) }

    subject! { get :index }

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

    it 'has meta tags' do
      expect(response.body).to include("<title>#{meta_data[:title]}</title>")
      expect(response.body).to include("<meta name=\"keywords\" content=\"#{meta_data[:keywords]}\" />")
      expect(response.body).to include("<meta name=\"description\" content=\"#{meta_data[:description]}\" />")
    end

    it 'has paginator' do
      expect(response.body).to include(I18n.t(:go_to_page))
      expect(response.body).to include("#{blog_index_path}/page/2")
    end
  end

  describe '#show' do
    let!(:article) { create :article }

    subject! { get :show, params: { id: article.seo_url } }

    it do
      expect(response).to render_template(:show)
      expect(response.status).to eq 200
    end

    it 'has meta tags' do
      expect(response.body).to include("<title>#{article[:title]}</title>")
      expect(response.body).to include("<meta name=\"keywords\" content=\"#{article[:keywords]}\" />")
      expect(response.body).to include("<meta name=\"description\" content=\"#{article[:meta_description]}\" />")
    end

    it 'has content' do
      expect(response.body).to include(article[:title])
      expect(response.body).to include(article[:text])
    end
  end
end
