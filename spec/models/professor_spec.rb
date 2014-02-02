require 'spec_helper'

describe Professor do
  let(:submission) { FactoryGirl.create(:submission) }
  before {
    @professor = Professor.new(
      name: "Carol Wellington",
      email: "cawell@ship.edu",
    )
  }

  subject { @professor }

  it { should be_valid }

  #Tests for our fields existing
  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:submissions) }

  it { should have_many(:submissions) }

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

  describe "when email is already taken" do
    before do
      prof_with_same_email = @professor.dup
      prof_with_same_email.email = @professor.email.upcase
      prof_with_same_email.save
    end
    it { should_not be_valid }
  end

  describe "it should save with lowercase email" do
    before { @professor.email = @professor.email.upcase }
    it "should be lowercase" do
      @professor.save
      expect(@professor.email).to eq(@professor.email.downcase)
    end
  end

end