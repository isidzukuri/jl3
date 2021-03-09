require 'spec_helper'

RSpec.describe Content::Services::HomePage do
  describe '.call' do
    subject { described_class.new.call }

    context 'articles exists' do
      let!(:article_0) { create :article, title: 'a0', published: false }
      let!(:article_1) { create :article, title: 'a1' }
      let!(:article_2) { create :article, title: 'a2' }
      let!(:article_3) { create :article, title: 'a3' }
      let!(:article_4) { create :article, title: 'a4' }

      it { expect(subject[:articles].size).to eq(3) }
      it 'has articles ordered by id' do
        expect(subject[:articles][0]).to eq(article_4)
        expect(subject[:articles][1]).to eq(article_3)
        expect(subject[:articles][2]).to eq(article_2)
      end

      it 'has articles with attributes' do
        expect(subject[:articles][0][:title]).to eq(article_4[:title])
        expect(subject[:articles][0][:photo]).to eq(article_4[:photo])
        expect(subject[:articles][0][:description]).to eq(article_4[:description])
        expect(subject[:articles][0][:seo_url]).to eq(article_4[:seo_url])
        expect(subject[:articles][0][:img_title]).to eq(article_4[:img_title])
        expect(subject[:articles][0][:img_alt]).to eq(article_4[:img_alt])
        expect(subject[:articles][0][:id]).to eq(article_4[:id])
      end
    end

    context 'text block present' do
      let!(:text_block) { create(:text_block, type: :home, related: 0) }

      it { expect(subject[:text]).to eq(text_block.text) }
    end

    context 'meta data present' do
      let!(:meta_data) { create(:meta_data, type: :home) }

      it { expect(subject[:metadata][:description]).to eq(meta_data.description) }
      it { expect(subject[:metadata][:keywords]).to eq(meta_data.keywords) }
      it { expect(subject[:metadata][:title]).to eq(meta_data.title) }
    end

    context 'last book present' do
      let!(:book_1) { create :book }
      let!(:book_2) { create :book }
      let!(:book_3) { create :book }
      let(:last_books_ids) { [book_3.id, book_1.id].join(',') }

      before do
        ActiveRecord::Base.connection
                          .exec_query("INSERT INTO front_page (last) VALUES ('#{last_books_ids}');")
      end

      it { expect(subject[:last_books].size).to eq(2) }
      it { expect(subject[:last_books][0][:cover]).to eq(book_1.cover) }
    end
  end
end
