require 'spec_helper'

RSpec.describe TagsController do
  render_views
  
  let!(:tags) { create_list :tag, 2 }

  describe '#index' do
    let!(:invisible_tag) { create :tag, visible: 0 }

    subject! { get :index }

    it do
      expect(response).to render_template(:index)
      expect(response.status).to eq 200
    end

    it 'has tags' do
      expect(response.body).to include(tags[0][:title])
      expect(response.body).to include(tags[0][:seo_url])
      expect(response.body).to include(tags[1][:title])
      expect(response.body).to include(tags[1][:seo_url])
      expect(response.body).not_to include(invisible_tag[:title])
      expect(response.body).not_to include(invisible_tag[:seo_url])
    end

    it 'has meta tags' do
      expect(response.body).to include("<title>#{I18n.t(:title_tag_list)}</title>")
      expect(response.body).to include("<meta name=\"keywords\" content=\"#{I18n.t(:keywords_tag_list)}\" />")
      expect(response.body).to include("<meta name=\"description\" content=\"#{I18n.t(:description_tag_list)}\" />")
    end
  end

  describe '#show' do
    let!(:book_1) { create :book, bookname: 'A', tags: [tags[0]] }
    let!(:book_2) { create :book, bookname: 'A', tags: [tags[1]] }
    let!(:books) { create_list :book, 100, bookname: 'B', tags: [tags[0]] }
    # let!(:text_block) { create(:text_block, type: :genre, related: 0) }

    subject! { get :show, params: { id: tags[0].seo_url } }

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
      expect(response.body).to include("tag/#{tags[0].seo_url}/page/2")
    end
  end
end
