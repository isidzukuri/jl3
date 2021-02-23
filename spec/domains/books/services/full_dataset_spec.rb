require 'spec_helper'

RSpec.describe Books::Services::FullDataset do
  describe '#call' do
    subject { described_class.new.call(id) }

    let(:author) { create(:author) }
    let(:genre) { create(:genre) }
    let!(:book_support) { create(:book_support, book: book) }
    let!(:meta_data) { create(:meta_data, :book) }
    let!(:text_block) { create(:text_block, :book) }
    let!(:book) { create(:book, author: author, genre: genre) }
    let!(:book_2) { create(:book) }
    let(:id) { book.id }

    it 'calls query' do
      expect(Books::Queries::FullDataset).to receive(:new).and_call_original
      expect_any_instance_of(Books::Queries::FullDataset).to receive(:call).with(id)

      subject
    end

    context 'book with tags' do
      let!(:tag_1) { create(:book_tag, book: book).tag }
      let!(:tag_2) { create(:book_tag, book: book).tag }
      let!(:tag_3) { create(:book_tag, book: book, tag: create(:tag, visible: false)) }
      let!(:tag_4) { create(:book_tag, book: book_2) }

      it { expect(subject[:tags_list].length).to eq 2 }
      it { expect(subject[:tags_list]).to include(tag_1) }
      it { expect(subject[:tags_list]).to include(tag_2) }
    end

    context 'book data not found' do
      before { allow_any_instance_of(Books::Queries::FullDataset).to receive(:call).and_return(nil) }

      it { is_expected.to be_nil }
    end
  end
end
