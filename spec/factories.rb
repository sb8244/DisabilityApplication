FactoryGirl.define do
  factory :professor do
    sequence(:name){|n| "Carol #{n} Wellington"}
    sequence(:email){|n| "user#{n}@factory.com" }
  end

  factory :submission do
    sequence(:student_name) { |n| "Student #{n}" }
    student_email "student@ship.edu"
    course_number "CSC411"
    start_time    DateTime.now
    actual_test_length 50
    student_test_length  100
    exam_pickup   "Professor Dropoff"
    exam_return   "Student Pickup"
    reader        false
    laptop        false
    scribe        false
    professor
  end
end
