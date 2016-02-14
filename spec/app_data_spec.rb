require 'spec_helper'

describe AppData do
  let(:destination_xml ) { File.open("spec/sample/destinations.xml") }
  let(:locations_xml )   { File.open("spec/sample/taxonomy.xml") }

  let(:struct) { Struct.new(:taxonomy_path, :destinations_path) }
  let(:opts)   { struct.new(locations_xml, destination_xml) }

  subject      { described_class.new(opts) }

  let(:parsed_location) do
    {
      "355064" => { parent: nil, children: ["355611"] },
      "355611" => { parent: "355064", children: [] }
    }
  end

  let(:parsed_destinations) do
    {
      "355064" => {
        atlas_id: "355064",
        title: "Africa",
        history: "You’ve probably heard the claim that Africa is ‘the birthplace of humanity’."
      }
    }
  end

  describe "#load" do
    before { subject.load }

    it "returns parsed locations" do
      expect(
        subject.taxonomies
      ).to eq(parsed_location)
    end

    it 'returns parsed destinations' do
      expect(
        subject.destinations
      ).to eq(parsed_destinations)
    end
  end
end
