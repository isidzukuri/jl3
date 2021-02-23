require 'spec_helper'

RSpec.describe Books::Queries::FullDataset do
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

    it 'has attributes' do
      expect(subject[:id]).to eq(book.id)
      expect(subject[:authorid]).to eq(book.authorid)
      expect(subject[:bookname]).to eq(book.bookname)
      expect(subject[:genre]).to eq(genre.id.to_s)
      expect(subject[:bookdescribe]).to eq(book.bookdescribe)
      expect(subject[:cover]).to eq(book.cover)
      expect(subject[:txtfile]).to eq(book.txtfile)
      expect(subject[:txt_size_kb]).to eq(book.txt_size_kb)
      expect(subject[:seo]).to eq(book.seo)
      expect(subject[:f_name]).to eq(author.f_name)
      expect(subject[:l_name]).to eq(author.l_name)
      expect(subject[:author_seo]).to eq(author.seo)
      expect(subject[:name]).to eq(genre.name)
      expect(subject[:seo_name]).to eq(genre.seo_name)
      expect(subject[:censorship]).to eq(book_support.censorship)
      expect(subject[:shop_url]).to eq(book_support.shop_url)
      expect(subject[:author_link]).to eq(book_support.author_link)
      expect(subject[:shop_msg]).to eq(book_support.shop_msg)
      expect(subject[:bad_txt]).to eq(book_support.bad_txt)
      expect(subject[:bad_doc]).to eq(book_support.bad_doc)
      expect(subject[:bad_fb2]).to eq(book_support.bad_fb2)
      expect(subject[:bad_epub]).to eq(book_support.bad_epub)
      expect(subject[:bad_jar]).to eq(book_support.bad_jar)
      expect(subject[:meta_title]).to eq(meta_data.title)
      expect(subject[:meta_keywords]).to eq(meta_data.keywords)
      expect(subject[:meta_description]).to eq(meta_data.description)
      expect(subject[:text_block]).to eq(text_block.text)
      expect(subject[:rating]).to eq(nil)
      expect(subject[:ratings_count]).to eq(0)
    end

    context 'book with ratings' do
      let!(:book_rating_1) { create(:book_rating, book: book, rate: 5) }
      let!(:book_rating_2) { create(:book_rating, book: book, rate: 4) }
      let!(:book_2_rating) { create(:book_rating, book: book_2) }

      it { expect(subject[:ratings_count]).to eq(2) }
      it { expect(subject[:rating]).to eq(4.5) }
    end

    context 'book seo slug given as id' do
      let(:id) { book.seo }

      it { is_expected.to be_a(Hash) }
    end

    context 'book id given as a string' do
      let(:id) { book.id.to_s }

      it { is_expected.to be_a(Hash) }
    end

    context 'book not found' do
      let(:id) { 999 }

      it { is_expected.to be_nil }
    end
  end
end
