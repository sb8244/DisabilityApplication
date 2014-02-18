require 'spec_helper'

describe Submission do
  let(:professor) { FactoryGirl.create(:professor) }
  before {
    @submission = Submission.new(
      student_name: "Student",
      student_email: "student@ship.edu",
      course_number: "CSC411",
      start_time: DateTime.now,
      class_length: 50,
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

  it { should respond_to(:student_name) }
  it { should respond_to(:student_email) }
  it { should respond_to(:course_number) }
  it { should respond_to(:start_time) }
  it { should respond_to(:class_length) }
  it { should respond_to(:exam_pickup) }
  it { should respond_to(:exam_return) }
  it { should respond_to(:reader) }
  it { should respond_to(:scribe) }
  it { should respond_to(:laptop) }
  it { should respond_to(:professor) }
  it { should respond_to(:professor_id) }
  
  it { should belong_to(:professor) }

  describe "when student_name is not present" do 
    before { @submission.student_name = " " }
    it { should_not be_valid }
  end

  describe "when student_email is not present" do 
    before { @submission.student_email = " " }
    it { should_not be_valid }
  end

  describe "when course_number is not present" do 
    before { @submission.course_number = " " }
    it { should_not be_valid }
  end

  describe "when start_time is not a date" do 
    before { @submission.start_time = " " }
    it { should_not be_valid }
  end

  describe "when class_length is not an integer" do 
    before { @submission.class_length = " " }
    it { should_not be_valid }
  end

  describe "when exam_pickup is not present" do 
    before { @submission.exam_pickup = " " }
    it { should_not be_valid }
  end

  describe "when exam_return is not present" do 
    before { @submission.exam_return = " " }
    it { should_not be_valid }
  end

  describe "when reader is not present" do 
    before { @submission.reader = "" }
    it { should_not be_valid }
  end

  describe "when scribe is not present" do 
    before { @submission.scribe = "" }
    it { should_not be_valid }
  end

  describe "when laptop is not present" do 
    before { @submission.laptop = "" }
    it { should_not be_valid }
  end

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