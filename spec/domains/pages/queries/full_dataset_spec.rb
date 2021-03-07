require 'spec_helper'

RSpec.describe Pages::Queries::FullDataset do
  describe '#call' do
    subject { described_class.new.call(id) }

    let!(:page) { create(:page) }
    let!(:meta_data) { create(:meta_data, type: :page, related: page.id) }
    let!(:text_block) { create(:text_block, type: :page, related: page.id) }
    let(:id) { page.id }

    it 'has attributes' do
      expect(subject[:name]).to eq(page.name)
      expect(subject[:title]).to eq(meta_data.title)
      expect(subject[:keywords]).to eq(meta_data.keywords)
      expect(subject[:description]).to eq(meta_data.description)
      expect(subject[:text]).to eq(text_block.text)
    end

    context 'page seo slug given as id' do
      let(:id) { page.seo_name }

      it { is_expected.to be_a(Hash) }
    end

    context 'page id given as a string' do
      let(:id) { page.id.to_s }

      it { is_expected.to be_a(Hash) }
    end

    context 'page not found' do
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
