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
submission.professor = professor
submission.save