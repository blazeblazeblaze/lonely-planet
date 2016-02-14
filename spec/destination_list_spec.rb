require 'spec_helper'

describe DestinationList do
  subject { described_class.new(raw_destinations, raw_locations) }
  let(:raw_destinations) do
    {
      "222" => { title: "title", atlas_id: 222 }
    }
  end

  let(:raw_locations) do
    {
      "123" => { id: "123", parent: "222", children: ["222"] }
    }
  end

  describe "#destinations" do
    it "reduces destinations. Returns hash of Destinations" do
      expect(
        subject.destinations
      ).to be_an_instance_of(Hash)
    end
  end

  describe "#parent_for" do
    context "parent is present" do
      it "returns destination" do
        expect(
          subject.parent_for("123")
        ).to be_an_instance_of(Destination)
      end
    end

    context "parent is not present" do
      it "returns nil" do
        expect(
          subject.parent_for("4423")
        ).to be_nil
      end
    end
  end

  describe "#children_for" do
    context "parent is present" do
      it "returns destination" do
        expect(
          subject.children_for("123")[0]
        ).to be_an_instance_of(Destination)
      end
    end

    context "parent is not present" do
      it "returns nil" do
        expect(
          subject.children_for("4423")
        ).to eq []
      end
    end
  end
end
