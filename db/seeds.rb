# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Submission.destroy_all
Professor.destroy_all

10.times { FactoryGirl.create(:submission) }
professor = Submission.first.professor

#sum limit + offset to get the item number (2nd in this case)
submission = Submission.limit(1).offset(1).first
submission.professor = professor
submission.save