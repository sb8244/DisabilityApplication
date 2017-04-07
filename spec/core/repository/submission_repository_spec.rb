require "core_helper"

RSpec.describe SubmissionRepository do
  describe ".one" do
    it "asks the adapter for the id" do
      expect(test_adapter).to receive(:one).once.with(1).and_return("test")
      expect(SubmissionRepository.one(1)).to eq("test")
    end
  end
end
