require 'spec_helper'

describe Cli::Options do
  subject { described_class.new }

  describe "#valid?" do
    context "file does not exist" do
      it "throws custom exception" do
        expect{
          subject.valid?
        }.to raise_error(MissingFileError)
      end
    end

    context "file exists" do
      before do
        subject.taxonomy_path     = __FILE__
        subject.destinations_path = __FILE__
      end

      it "returns true" do
        expect(
          subject.valid?
        ).to eq true
      end
    end

    context "no permissions to write" do
      before do
        subject.taxonomy_path     = __FILE__
        subject.destinations_path = __FILE__
        allow(subject).to receive(:readable?) { false }
      end

      it "throws custom exception" do
        expect{
          subject.valid?
        }.to raise_error(FilePermissionError)
      end
    end

    context "file is writeable" do
      before do
        subject.taxonomy_path     = __FILE__
        subject.destinations_path = __FILE__
      end

      it "returns true" do
        expect(
          subject.valid?
        ).to eq true
      end
    end
  end
end
