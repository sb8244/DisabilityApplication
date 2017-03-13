require "core_helper"

RSpec.describe Validator::SubmissionMailing do
  subject do
    SubmissionMailing.new(
      to: "test@test.com",
      date: Time.current,
      submission: SubmissionFactory.get_valid
    )
  end

  describe "valid?" do
    it "is true with valid fields" do
      expect(subject).to be_valid
    end

    it "requires to" do
      subject.to = nil
      expect(subject).not_to be_valid
    end

    it "requires a date" do
      subject.date = nil
      expect(subject).not_to be_valid
    end

    it "requires a submission" do
      subject.submission = nil
      expect(subject).not_to be_valid

      subject.submission = "nope"
      expect(subject).not_to be_valid
    end
  end
end
