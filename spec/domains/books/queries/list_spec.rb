require 'spec_helper'

RSpec.describe Books::Queries::List do
  describe '#call' do
    subject { described_class.new.call }

    let!(:book) { create(:book, bookname: 'B book') }
    let!(:book_2) { create(:book, bookname: 'A book') }

    it { is_expected.to be_a ActiveRecord::Relation }
    it { expect(subject.size).to eq 2 }

    it 'has attributes' do
      expect(subject[1][:id]).to eq(book.id)
      expect(subject[1][:bookname]).to eq(book.bookname)
      expect(subject[1][:txt_size_kb]).to eq(book.txt_size_kb)
      expect(subject[1][:seo]).to eq(book.seo)
    end

    it 'is ordered by bookname' do
      expect(subject[0][:id]).to eq(book_2.id)
      expect(subject[1][:id]).to eq(book.id)
    end
  end
end
