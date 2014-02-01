require 'spec_helper'

describe Submission do

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
      scribe: false
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

end
