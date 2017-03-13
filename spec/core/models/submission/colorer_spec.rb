require "core_helper"

describe Submission::Colorer do
  it "doesn't assign colors when no alike submissions" do
    submission_list = 10.times.map do
      SubmissionFactory.get_valid.tap do |submission|
        submission.course_number = SecureRandom.hex(20)
      end
    end

    colorer = Submission::Colorer.new(submission_list)

    expect(colorer.color).to eq({})
  end

  it "doesn't assign colors on different dates" do
    professor = ProfessorFactory.get_valid
    submission_list = 10.times.map do |index|
      SubmissionFactory.get_valid(professor: professor).tap do |submission|
        submission.start_time = DateTime.now + index.days
      end
    end

    colorer = Submission::Colorer.new(submission_list)

    expect(colorer.color).to eq({})
  end

  it "all same professor and course" do
    submission_list = []
    professor = ProfessorFactory.get_valid
    submission_list = 10.times.map do |index|
      SubmissionFactory.get_valid(professor: professor).tap do |submission|
        submission.course_number = "same"
      end
    end

    colorer = Submission::Colorer.new(submission_list)
    colors = colorer.color
    expected_color = colorer.color_list.first

    expect(colors.values.uniq.count).to eq(1)
    submission_list.each do |submission|
      expect(colors[submission]).to eq(expected_color)
    end
  end

  it "repeats same professor and course" do
    professors = [ProfessorFactory.get_valid, ProfessorFactory.get_valid]
    submission_list = 10.times.map do |index|
      SubmissionFactory.get_valid.tap do |submission|
        # Match submissions professor/course_number up in pairs of 2
        submission.professor = professors[index % 2]
        submission.course_number = index % 2
      end
    end

    colorer = Submission::Colorer.new(submission_list)
    colors = colorer.color

    expect(colors.values.uniq.count).to eq(2)
    submission_list.each do |submission|
      expect(colors[submission]).to eq(colorer.color_list[submission.course_number])
    end
  end
end
