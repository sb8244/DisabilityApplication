require 'spec_helper'

describe Submission::Colorer do
  it "doesn't assign colors when no alike submissions" do
    submission_list = []
    10.times do
      submission_list << SubmissionFactory.get_valid
      submission_list.last.course_number = SecureRandom.hex(20)
    end

    colorer = Submission::Colorer.new(submission_list)

    expect(colorer.color).to eq({})
  end

  it "doesn't assign colors on different dates" do
    submission_list = []
    10.times do |index|
      submission_list << SubmissionFactory.get_valid
      submission_list.last.professor = submission_list.first.professor
      submission_list.last.start_time = DateTime.now + index.days
    end

    colorer = Submission::Colorer.new(submission_list)

    expect(colorer.color).to eq({})
  end

  it "all same professor and course" do
    submission_list = []
    10.times do
      submission = SubmissionFactory.get_valid
      # All submissions have the same professor and course
      submission.professor = submission_list.first.professor if submission_list.first
      submission.course_number = "same"
      submission_list << submission
    end

    colorer = Submission::Colorer.new(submission_list)
    colors = colorer.color
    expected_color = colorer.color_list.first

    submission_list.each do |submission|
      expect(colors[submission]).to eq(expected_color)
    end
  end

  it "repeats same professor and course" do
    submission_list = []
    10.times do |index|
      submission = SubmissionFactory.get_valid
      # Match submissions professor/course_number up in pairs of 2
      submission.professor = submission_list[index % 5].professor if submission_list[index % 5]
      submission.course_number = index % 5
      submission_list << submission
    end

    colorer = Submission::Colorer.new(submission_list)
    colors = colorer.color

    submission_list.each do |submission|
      expect(colors[submission]).to eq(colorer.color_list[submission.course_number])
    end
  end
end
