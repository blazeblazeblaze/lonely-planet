require 'spec_helper'

describe Renderer::Page do
  subject { described_class.render { content } }
  let(:content) { "code exercise" }

  describe ".render" do
    it "renders template with content in it" do
      expect(subject).to include content
    end
  end
end
