FactoryGirl.define do
  factory :professor do
    sequence(:name){|n| "Carol #{n} Wellington"}
    sequence(:email){|n| "user#{n}@factory.com" }
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
    professor
  end
end
