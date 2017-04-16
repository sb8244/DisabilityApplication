require "core_helper"

RSpec.describe SubmissionMailing do
  subject do
    SubmissionMailing.new(
      to: "test@test.com",
      date: Time.current,
      submission: SubmissionFactory.get_valid
    )
  end

  describe "attributes" do
    [
      :submission, :to, :date
    ].each do |attribute|
      it { should respond_to(attribute) }
    end
  end

  describe "validations" do
    it { should be_valid }
  end
end
