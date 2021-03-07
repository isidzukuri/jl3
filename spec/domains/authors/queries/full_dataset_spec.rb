require 'spec_helper'

RSpec.describe Authors::Queries::FullDataset do
  describe '#call' do
    subject { described_class.new.call(id) }

    let!(:author) { create(:author) }
    let!(:meta_data) { create(:meta_data, type: :author, related: 0) }
    let!(:text_block) { create(:text_block, type: :author, related: 0) }
    let(:id) { author.id }

    it 'has attributes' do
      expect(subject[:id]).to eq(author.id)
      expect(subject[:f_name]).to eq(author.f_name)
      expect(subject[:l_name]).to eq(author.l_name)
      expect(subject[:full_name]).to eq(author.full_name)
      expect(subject[:bio]).to eq(author.bio)
      expect(subject[:title]).to eq(meta_data.title)
      expect(subject[:keywords]).to eq(meta_data.keywords)
      expect(subject[:description]).to eq(meta_data.description)
      expect(subject[:text]).to eq(text_block.text)
    end

    context 'author seo slug given as id' do
      let(:id) { author.seo }

      it { is_expected.to be_a(Hash) }
    end

    context 'author id given as a string' do
      let(:id) { author.id.to_s }

      it { is_expected.to be_a(Hash) }
    end

    context 'author not found' do
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
