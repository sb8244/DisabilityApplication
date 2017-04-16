require "core_helper"

RSpec.describe Validator::Professor do
  let(:professor) do
    Professor.new(name: "Test", email: "test@test.com")
  end

  subject { Validator::Professor.new(professor) }

  describe "valid?" do
    it "is true with a name and email" do
      expect(subject.valid?).to eq(true)
    end

    it "can be decorated with other validators" do
      decorated = Validator::Professor.new(Validator::Professor.new(professor))
      expect(decorated.valid?).to eq(true)
    end

    it "requires the name to be present" do
      professor.name = ""
      expect(subject).not_to be_valid
    end

    it "requires the email to be present" do
      professor.email = ""
      expect(subject).not_to be_valid
    end

    it "doesn't accept bad emails" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo. foo@bar_baz.com foo@bar+baz.com]
      addresses.each do |invalid_address|
        professor.email = invalid_address
        expect(subject).not_to be_valid
        expect(subject.errors.messages).to eq(email: ["is not an email"])
      end
    end
  end
end

