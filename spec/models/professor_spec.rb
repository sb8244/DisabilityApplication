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

  describe "adding submissions" do
    it { should respond_to(:submissions) }
    it { should have_many(:submissions) }

    it "should add a submission" do
      expect(@professor.submissions.count).to eq(0)
      @professor.submissions << submission
      expect(@professor.submissions.size).to eq(1)
      @professor.save
      expect(@professor.submissions.count).to eq(1)
    end

    it "should add many submissions" do
      expect(@professor.submissions.count).to eq(0)
      @professor.submissions << submission
      @professor.submissions << FactoryGirl.create(:submission)
      expect(@professor.submissions.size).to eq(2)
      @professor.save
      expect(@professor.submissions.count).to eq(2)
    end
  end

  describe "fuzzy email matching" do
    it "should match the beginning of an email" do
      @professor.email = "cawell@ship.edu"
      @professor.save
      expect(Professor.like_email("cawell").count).to eq(1)
    end
    it "should match the middle of an email" do
      @professor.email = "cawell@ship.edu"
      @professor.save
      expect(Professor.like_email("wel").count).to eq(1)
    end
    it "should match the end of an email" do
      @professor.email = "cawell@ship.edu"
      @professor.save
      expect(Professor.like_email("ship.edu").count).to eq(1)
    end
  end
end