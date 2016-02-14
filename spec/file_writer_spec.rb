require 'spec_helper'

describe FileWriter do
  subject { described_class.new }

  describe "#<<" do
    context "file is not writable" do
      it "raises error" do
        expect{
          subject << "some content"
        }.to raise_error(NoOpenFileError)
      end
    end

    context "file is writable" do
      before { subject.new_file("some file") }

      it 'writes to file' do
        expect{
          subject << "some content"
        }.to change{ subject.curr_file.size }
      end
    end
  end

  describe "#close" do
    context "cannot perform operation if file does not exist" do
      it "raises error" do
        expect{
          subject.close
        }.to raise_error(NoOpenFileError)
      end
    end

    context "file is writable" do
      before { subject.new_file("some file") }

      it "closes new file" do
        expect{
          subject.close
        }.to change{ subject.curr_file.closed? }.from(false).to(true)
      end
    end
  end

  describe "#new_file" do
    context "file does not exist yet" do
      it "creates new file" do
        expect{
          subject.new_file("some file")
        }.to change{ subject.curr_file }
      end
    end

    context "file to write already exists" do
      before { subject.new_file("some file") }

      it "raises error" do
        expect{
          subject.new_file("some file")
        }.to raise_error(NoFileToWrite)
      end
    end
  end
end
