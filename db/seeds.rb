# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Destroy all of the previous seeds
Submission.destroy_all
Professor.destroy_all

#Create a number of submissions
10.times { 
  sub = FactoryGirl.create(:submission)
}

#Set some of the submissions to have the same professor
professor = Submission.first.professor

#sum limit + offset to get the item number (2nd in this case)
submission = Submission.limit(1).offset(1).first
submission.update_attributes!(professor: professor)

submission = Submission.limit(1).offset(5).first
submission.update_attributes!(professor: professor)

# now set some more to have a different professor
professor = Submission.last.professor
submission = Submission.limit(1).offset(7).first
submission.update_attributes!(professor: professor)
submission = Submission.limit(1).offset(8).first
submission.update_attributes!(professor: professor)

# Let's set laptop on 1
submission = Submission.limit(1).offset(1).first
submission.update_attributes!(laptop: true, laptop_reason: "d2l")

# R on another
submission = Submission.limit(1).offset(2).first
submission.update_attributes!(reader: true)

# S on another
submission = Submission.limit(1).offset(3).first
submission.update_attributes!(scribe: true)

# RS on another
submission = Submission.limit(1).offset(4).first
submission.update_attributes!(scribe: true, reader: true)

# RSL on another
submission = Submission.limit(1).offset(5).first
submission.update_attributes!(scribe: true, reader: true, laptop: true)