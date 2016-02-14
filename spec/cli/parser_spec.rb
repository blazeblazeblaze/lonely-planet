require 'spec_helper'

describe Cli::Parser do
  subject          { described_class.new }
  let(:opt_parser) { double("some parser") }
  let(:args)       { double("some arguments") }

  before do
    allow(subject).to receive(:opt_parser) { opt_parser }
    allow(subject).to receive(:args)       { args }
  end

  describe '.parse' do
    before { allow(opt_parser).to receive(:parse!) }

    context "args are not valid" do
      before { allow(args).to receive(:valid?) { false } }

      it 'parses params using ruby lib - option parser' do
        expect(subject.parse).to be_nil
      end
    end

    context "args are valid" do
      before { allow(args).to receive(:valid?) { true } }

      it 'parses params using ruby lib - option parser' do
        expect(subject.parse).to eq args
      end
    end
  end
end
