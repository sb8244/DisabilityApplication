require "core_helper"

RSpec.describe Professor do
  subject do
    Professor.new(
      name: "Carol Wellington",
      email: "cawell@ship.edu",
    )
  end

  describe "attributes" do
    [
      :name, :email
    ].each do |attribute|
      it { should respond_to(attribute) }
    end
  end

  describe "validations" do
    it { should be_valid }

    it "uses the Validator::Professor by default" do
      expect(subject.validator).to be_a(Validator::Professor)
    end

    it "has the validator properly setup" do
      subject.name = ""
      expect(subject).not_to be_valid
    end
  end
end
