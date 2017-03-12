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

    it "requires the name to be present" do
      subject.name = ""
      expect(subject).not_to be_valid
    end

    it "requires the email to be present" do
      subject.email = ""
      expect(subject).not_to be_valid
    end

    it "doesn't accept bad emails" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo. foo@bar_baz.com foo@bar+baz.com]
      addresses.each do |invalid_address|
        subject.email = invalid_address
        expect(subject).not_to be_valid
        expect(subject.errors.messages).to eq(email: ["is not an email"])
      end
    end
  end
end
