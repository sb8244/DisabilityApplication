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
end
