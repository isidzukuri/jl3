require 'spec_helper'

RSpec.describe Tags::Queries::FullDataset do
  describe '#call' do
    subject { described_class.new.call(id) }

    let!(:tag) { create(:tag) }
    let!(:meta_data) { create(:meta_data, type: :tags, related: 0) }
    let!(:text_block) { create(:text_block, type: :tags, related: 0) }
    let(:id) { tag.id }

    it 'has attributes' do
      expect(subject[:title]).to eq(tag.title)
      expect(subject[:meta_title]).to eq(meta_data.title)
      expect(subject[:keywords]).to eq(meta_data.keywords)
      expect(subject[:description]).to eq(meta_data.description)
      expect(subject[:text]).to eq(text_block.text)
    end

    context 'tag seo slug given as id' do
      let(:id) { tag.seo_url }

      it { is_expected.to be_a(Hash) }
    end

    context 'tag id given as a string' do
      let(:id) { tag.id.to_s }

      it { is_expected.to be_a(Hash) }
    end

    context 'tag not found' do
      let(:id) { 999 }

      it { is_expected.to be_nil }
    end

    context 'no meta_data found' do
      let!(:meta_data) { nil }

      it 'has attributes' do
        expect(subject[:meta_title]).to be_nil
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
