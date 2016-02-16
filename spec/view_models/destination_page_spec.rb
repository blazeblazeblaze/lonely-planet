require 'spec_helper'

describe ViewModels::DestinationPage do
  let(:destination) { double("some robot") }
  subject           { described_class.new(destination) }

  describe '#title' do
    it 'delegates title do destination' do
      expect(destination).to receive(:title)
      subject.title
    end
  end

  describe '#content' do
    it 'delegates content (history) do destination' do
      expect(destination).to receive(:history)
      expect(destination).to receive(:overview)
      subject.content
    end
  end

  describe '#atlas_id' do
    it 'delegates atlas_id do destination' do
      expect(destination).to receive(:atlas_id)
      subject.atlas_id
    end
  end

  describe '#children' do
    let(:struct) { Struct.new(:title, :atlas_id, :children) }

    context 'no children available' do
      let(:destination) { struct.new("costa rica", 123, []) }

      it 'returns empty array' do
        expect(
          subject.children
        ).to eq []
      end
    end

    context 'children is present' do
      let(:child)       { struct.new("America", 124) }
      let(:destination) { struct.new("costa rica", 123, [child]) }

      it 'returns adapted array' do
        expect(
          subject.children
        ).to eq [{ title: "America", atlas_id: 124 }]
      end
    end
  end

  describe '#parents' do
    let(:struct) { Struct.new(:title, :atlas_id, :parent) }

    context 'no parents available' do
      let(:destination) { struct.new("costa rica", 123) }

      it 'returns array with self' do
        expect(
          subject.parents
        ).to eq [{ title: "costa rica", atlas_id: 123 }]
      end
    end

    context 'parents is present' do
      let(:parent)      { struct.new("America", 124) }
      let(:destination) { struct.new("costa rica", 123, parent) }

      it 'returns adapted array' do
        expect(
          subject.parents
        ).to eq [
          { title: "America", atlas_id: 124 },
          { title: "costa rica", atlas_id: 123 }]
      end
    end
  end

end
