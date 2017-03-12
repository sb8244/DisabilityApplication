require "core_helper"

RSpec.describe Submission do
  let(:professor) { Professor.new(name: "Test", email: "test@test.com") }

  subject do
    Submission.new(
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
  end

  describe "attributes" do
    [
      :student_name, :student_email, :course_number, :start_time, :actual_test_length,
      :student_test_length, :exam_pickup, :exam_return, :reader, :laptop, :scribe, :professor
    ].each do |attribute|
      it { should respond_to(attribute) }
    end
  end

  describe "validations" do
    it { should be_valid }
  end

  describe "start_time_formatted" do
    it "is '' without a start_time" do
      subject.start_time = nil
      expect(subject.start_time_formatted).to eq("")
    end

    it "is long_ordinal formatted with a time present" do
      subject.start_time = Time.parse("March 12th, 2017 1:21 PM")
      expect(subject.start_time_formatted).to eq("March 12th, 2017 13:21")
    end
  end

  describe "end_time" do
    it "is nil without a start_time" do
      subject.start_time = nil
      expect(subject.end_time).to eq(nil)
    end

    it "is the time + the student_test_length in minutes" do
      subject.start_time = Time.parse("March 12th, 2017 1:21 PM")
      subject.student_test_length = 90
      expect(subject.end_time).to eq(subject.start_time + 90.minutes)
    end
  end
end
