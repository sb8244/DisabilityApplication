FactoryGirl.define do
  factory :professor do
    name     "Carol Wellington"
    email    "cawell@ship.edu"
  end

  factory :submission do
    student_name  "Student"
    student_email "student@ship.edu"
    course_number "CSC411"
    start_time    DateTime.now
    class_length  50
    exam_pickup   "Student"
    exam_return   "Student"
    reader        false
    laptop        false
    scribe        false
    association :professor, factory: :professor
  end
end
