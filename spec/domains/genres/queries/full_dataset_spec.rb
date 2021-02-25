require 'spec_helper'

RSpec.describe Genres::Queries::FullDataset do
  describe '#call' do
    subject { described_class.new.call(id) }

    let!(:genre) { create(:genre) }
    let!(:meta_data) { create(:meta_data, type: :genre, related: genre.id) }
    let!(:text_block) { create(:text_block, type: :genre, related: genre.id) }
    let(:id) { genre.id }

    it 'has attributes' do
      expect(subject[:name]).to eq(genre.name)
      expect(subject[:title]).to eq(meta_data.title)
      expect(subject[:keywords]).to eq(meta_data.keywords)
      expect(subject[:description]).to eq(meta_data.description)
      expect(subject[:text]).to eq(text_block.text)
    end

    context 'genre seo slug given as id' do
      let(:id) { genre.seo_name }

      it { is_expected.to be_a(Hash) }
    end

    context 'genre id given as a string' do
      let(:id) { genre.id.to_s }

      it { is_expected.to be_a(Hash) }
    end

    context 'genre not found' do
      let(:id) { 999 }

      it { is_expected.to be_nil }
    end

    context 'no meta_data found' do
      let!(:meta_data) { nil }

      it 'has attributes' do
        expect(subject[:title]).to be_nil
        expect(subject[:keywords]).to be_nil
        expect(subject[:description]).to be_nil
      end
    end

    context 'no text_block found' do
      let!(:text_block) { nil }

      it { expect(subject[:text]).to be_nil }
    end
  end
end
