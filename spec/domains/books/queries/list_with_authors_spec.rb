require 'spec_helper'

RSpec.describe Books::Queries::ListWithAuthors do
  describe '#call' do
    subject { described_class.new.call }

    let(:author) { create(:author) }
    let!(:book) { create(:book, bookname: 'B book', author: author) }
    let!(:book_2) { create(:book, bookname: 'A book') }

    it { is_expected.to be_a ActiveRecord::Relation }
    it { expect(subject.size).to eq 2 }

    it 'has attributes' do
      expect(subject[1][:id]).to eq(book.id)
      expect(subject[1][:authorid]).to eq(book.authorid)
      expect(subject[1][:bookname]).to eq(book.bookname)
      expect(subject[1][:txt_size_kb]).to eq(book.txt_size_kb)
      expect(subject[1][:seo]).to eq(book.seo)
      expect(subject[1][:f_name]).to eq(author.f_name)
      expect(subject[1][:l_name]).to eq(author.l_name)
      expect(subject[1][:author_seo]).to eq(author.seo)
    end

    it 'is ordered by bookname' do
      expect(subject[0][:id]).to eq(book_2.id)
      expect(subject[1][:id]).to eq(book.id)
    end
  end
end
