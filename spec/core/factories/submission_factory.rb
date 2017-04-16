class SubmissionFactory
  def self.get_valid(professor: ProfessorFactory.get_valid)
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
end
