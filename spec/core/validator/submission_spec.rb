require "core_helper"

RSpec.describe Validator::Submission do
  let(:submission) do
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
      professor: Professor.new
    )
  end

  subject { Validator::Submission.new(submission) }

  describe "valid?" do
    [
      :student_name, :student_email, :course_number, :exam_pickup, :exam_return
    ].each do |required_attribute|
      it "is not valid with a blank #{required_attribute}" do
        subject.send("#{required_attribute}=", " ")
        expect(subject).not_to be_valid
      end
    end

    it "requires a valid student_email" do
      subject.student_email = "nope@nope"
      expect(subject).not_to be_valid
    end

    [
      :actual_test_length, :student_test_length
    ].each do |numeric_attribute|
      it "requires numericality for #{numeric_attribute}" do
        subject.send("#{numeric_attribute}=", "a")
        expect(subject).not_to be_valid
        subject.send("#{numeric_attribute}=", "1")
        expect(subject).to be_valid
        subject.send("#{numeric_attribute}=", 100_000)
        expect(subject).to be_valid
      end
    end

    [
      :reader, :scribe, :laptop
    ].each do |boolean_attribute|
      it "requires #{boolean_attribute} to be true/false" do
        subject.send("#{boolean_attribute}=", true)
        expect(subject).to be_valid
        subject.send("#{boolean_attribute}=", false)
        expect(subject).to be_valid

        subject.send("#{boolean_attribute}=", nil)
        expect(subject).not_to be_valid
        subject.send("#{boolean_attribute}=", "junk")
        expect(subject).not_to be_valid
      end
    end
  end
end
