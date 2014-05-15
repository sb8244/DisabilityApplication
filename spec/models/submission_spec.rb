require 'spec_helper'

describe Submission do
  let(:professor) { FactoryGirl.create(:professor) }
  before {
    @submission = Submission.new(
      student_name: "Student",
      student_email: "student@ship.edu",
      course_number: "CSC411",
      start_time: DateTime.now,
      actual_test_length: 50,
      student_test_length: 100,
      exam_pickup: "Student",
      exam_return: "Student",
      reader: false,
      laptop: false,
      scribe: false,
      professor: professor
    )
  }

  subject { @submission }

  it { should be_valid }

  describe "when professor does not exist" do
    before { @submission.professor = Professor.new(name: "test", email: "test@test.com")}

    it { should_not be_valid }

    it "is valid if professor is saved" do
      @submission.professor.save
      expect(@submission).to be_valid
    end
  end

  describe "find_in_date scope" do
    it "gets a submission for today" do
      expected = FactoryGirl.create(:submission)

      beginning = DateTime.now.beginning_of_day
      ending = DateTime.now.end_of_day

      expect(Submission.find_in_date(beginning, ending).load).to eq([expected])
    end

    it "does not get a submission for yesterday" do
      expected = FactoryGirl.create(:submission)

      beginning = DateTime.now.beginning_of_day - 1.days
      ending = DateTime.now.end_of_day - 1.days

      expect(Submission.find_in_date(beginning, ending).load).to eq([])
    end
  end

  describe "today scope" do
    it "gets a submission for today" do
      expected = FactoryGirl.create(:submission)

      Submission.today.each do |submission|
        expect(submission).to eq(expected)
      end
    end

    it "gets all submissions for today" do
      expected = FactoryGirl.create(:submission)
      expected2 = FactoryGirl.create(:submission)

      submissions = []
      Submission.today.each do |submission|
        submissions << submission
      end
      expect(submissions[0]).to eq(expected)
      expect(submissions[1]).to eq(expected2)
    end

    it "gets a submission for today ignoring yesterday and tomorrow" do
      expected = FactoryGirl.create(:submission)
      previous = FactoryGirl.build(:submission)
      future = FactoryGirl.build(:submission)

      previous.start_time = DateTime.now - 1.days
      future.start_time = DateTime.now + 1.days
      previous.save!
      future.save!

      Submission.today.each do |submission|
        expect(submission).to eq(expected)
      end
    end
  end

end
