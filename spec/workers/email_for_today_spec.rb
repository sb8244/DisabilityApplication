require 'spec_helper'

describe EmailForToday do

  it "sends no emails when there are no submissions" do
    query = Submission.today
    query.should_receive(:each).once

    TodaySubmissionsMailer.should_not_receive(:send)
    EmailForToday.new(query).perform
  end

  it "sends X when there are X" do
    submissions = []
    3.times do
      submissions << FactoryGirl.create(:submission)
    end
    query = Submission.today
    #Yield the submissions in sequence
    query.should_receive(:each).once.
      and_yield(submissions[0]).
      and_yield(submissions[1]).
      and_yield(submissions[2])

    #Expect the submissions are emailed in sequence
    submissions.each do |submission|
      TodaySubmissionsMailer.should_receive(:send).once.ordered.with(submission)
    end
    EmailForToday.new(query).perform
  end

end