require 'spec_helper'

describe Professor do

  before {
    @professor = Professor.new(
      name: "Carol Wellington",
      email: "cawell@ship.edu"
    )
  }

  subject { @professor }

  #Tests for our fields existing
  it { should respond_to(:name) }
  it { should respond_to(:email) }

  describe "when name is not present" do
    before { @professor.name = " " }
    it { should_not be_valid }
  end

  describe "when email has invalid format" do
    it "should be invalid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                     foo@bar_baz.com foo@bar+baz.com]
      addresses.each do |invalid_address|
        @professor.email = invalid_address
        expect(@professor).not_to be_valid
      end
    end
  end

  describe "when email has valid format" do
    it "should be valid" do
      addresses = %w[test@test.com]
      addresses.each do |valid_address|
        @professor.email = valid_address
        expect(@professor).to be_valid
      end
    end
  end
end
