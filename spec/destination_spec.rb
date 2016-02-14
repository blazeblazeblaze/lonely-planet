require 'spec_helper'

describe Destination do
  subject { described_class.new(raw, destination_list) }

  let(:destination_list) { double("some list") }

  let(:raw) do
    {
      title: "some title",
      atlas_id: 123,
      history: "history"
    }
  end

  describe "parent" do
    it 'uses destination list to determine child' do
      expect(
        destination_list
      ).to receive(:parent_for).with(123)

      subject.parent
    end
  end

  describe "children" do
    # destination_list.children_for(atlas_id)
    it 'uses destination list to determine child' do
      expect(
        destination_list
      ).to receive(:children_for).with(123)

      subject.children
    end
  end

  describe "title" do
    it 'returns title' do
      expect(
        subject.title
      ).to eq raw[:title]
    end
  end

  describe "atlas_id" do
    it 'returns atlas_id' do
      expect(
        subject.atlas_id
      ).to eq raw[:atlas_id]
    end
  end

  describe "history" do
    it 'returns history' do
      expect(
        subject.history
      ).to eq raw[:history]
    end
  end
end
