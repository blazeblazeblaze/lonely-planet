require 'spec_helper'

describe Renderer::Destination do
  let(:destination) { { title: "Costa Rica", atlas_id: 123, children: 124 } }
  let(:child)       { { title: "San Jose", atlas_id: 124, parent: 123 } }

  before do
    allow(destination).to receive(:parent)   { nil }
    allow(destination).to receive(:children) { [child] }
    allow(destination).to receive(:history)  { "some history" }
  end

  describe ".renderer" do
    it "renders destination html content" do
      expect(
        described_class.render(destination)
      ).to include("Costa Rica", "San Jose")
    end
  end
end
