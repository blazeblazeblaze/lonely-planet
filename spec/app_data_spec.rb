require 'spec_helper'

describe AppData do
  let(:struct) { Struct.new(:taxonomy_path, :destinations_path) }
  let(:opts)   { struct.new(__FILE__, __FILE__) }

  subject      { described_class.new(opts) }

  describe "#load" do
    before do
      allow(subject).to receive(:taxonomies_nodes)   { Thread.new{} }
      allow(subject).to receive(:destinations_nodes) { Thread.new{} }
    end

    it "creates 2 threads and joins. returns array." do
      expect(
        subject.load
      ).to be_an_instance_of(Array)
    end
  end
end
