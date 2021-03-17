require 'spec_helper'

RSpec.describe FirstLettersController do
  render_views

  describe '#show' do
    let!(:letter) { create :letter, symbol: 'A' }
    let!(:authors) { create_list :author, 100, l_name: 'Aa' }
    let!(:author_1) { create :author, l_name: 'a1' }
    let!(:author_2) { create :author, l_name: 'a2' }
    let!(:author_3) { create :author, l_name: 'B' }
    let!(:meta_data) { create(:meta_data, type: :letter) }
    let!(:text_block) { create(:text_block, type: :letter, related: 0) }

    subject! { get :show, params: { id: letter.id } }

    it do
      expect(response).to render_template(:show)
      expect(response.status).to eq 200
    end

    it 'has authors' do
      expect(response.body).to include(author_1[:full_name])
      expect(response.body).to include(author_2[:full_name])
      expect(response.body).not_to include(author_3[:full_name])
      expect(response.body).to include(author_path(author_1[:seo]))
      expect(response.body).to include(author_path(author_2[:seo]))
    end

    it 'has meta tags' do
      expect(response.body).to include("<title>#{meta_data[:title]} #{letter.symbol}</title>")
      expect(response.body).to include("<meta name=\"keywords\" content=\"#{meta_data[:keywords]} #{letter.symbol}\" />")
      expect(response.body).to include("<meta name=\"description\" content=\"#{meta_data[:description]} #{letter.symbol}\" />")
    end

    it 'has paginator' do
      expect(response.body).to include(I18n.t(:go_to_page))
      expect(response.body).to include("fsymbol/#{letter.id}/page/2")
    end
  end
end
