require 'spec_helper'

describe Destination do
  subject { described_class.new(raw, destination_list) }

  let(:destination_list) { double("some list") }

  let(:raw) do
    {
      title: "some title",
      atlas_id: 123,
      history:  "some history",
      overview: "some overview"
    }
  end

  describe "#parent" do
    it 'uses destination list to determine parent' do
      expect(
        destination_list
      ).to receive(:parent_for).with(123)

      subject.parent
    end
  end

  describe "#children" do
    it 'uses destination list to determine child' do
      expect(
        destination_list
      ).to receive(:children_for).with(123)

      subject.children
    end
  end
end
