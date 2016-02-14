require 'spec_helper'

describe NodeParser do
  let(:io)        { StringIO.new }
  let(:handler)   { double("Some handler") }
  let(:subject)   { described_class.new(xml: io, handler: handler) }

  describe ".new" do
    it "runs Ox parse on init" do
      expect(Ox).to receive(:sax_parse).with(handler, io)
      subject
    end
  end

  describe '#parse' do
    let(:raw_locations) { ["355064",["355611", ["355612"]]] }

    before do
      allow(handler).to receive(:location_nodes) { raw_locations }
    end

    it 'hashifies xml' do
      expect(handler).to receive(:location_nodes)
      subject.parse
    end

    it 'returns hashified xml' do
      subject.parse
      expect(subject.nodes).to eq({
        "355064" => {:parent=>nil, :children=>["355611"]},
        "355611" => {:parent=>"355064", :children=>["355612"]},
        "355612" => {:parent=>"355611", :children=>[]}
      })
    end
  end
end
