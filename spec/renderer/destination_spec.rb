require 'spec_helper'

describe Renderer::Destination do
  let(:klass)       { Struct.new(:title, :atlas_id, :children, :parent) }
  let(:destination) { klass.new("Costa Rica", 123) }
  let(:child)       { klass.new("San Jose", 124) }
  let(:parent)      { klass.new("America", 125) }

  before do
    allow(destination).to receive(:children) { [child] }
    allow(destination).to receive(:parent)   { parent }
    allow(destination).to receive(:history)  { "some history" }
  end

  describe ".renderer" do
    it "renders destination html content" do
      expect(
        described_class.render(destination)
      ).to include("Costa Rica", "San Jose", "America")
    end
  end
end
