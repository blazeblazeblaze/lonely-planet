require 'spec_helper'

describe DestinationParser do
  let(:io)      { StringIO.new }
  let(:handler) { double("Some handler") }
  let(:subject) { described_class.new(xml: io, handler: handler) }

  describe ".new" do
    it "runs Ox parse on init" do
      expect(Ox).to receive(:sax_parse).with(handler, io)
      subject
    end
  end

  describe '#parse' do
    let(:node_item) { { atlas_id: 123 } }
    before do
      allow(handler).to receive(:nodes) { [node_item] }
    end

    it 'hashifies xml' do
      expect(handler).to receive(:nodes)
      subject.parse
    end

    it 'returns hashified xml' do
      expect(
        subject.parse
      ).to eq({ 123 => node_item })
    end
  end
end
