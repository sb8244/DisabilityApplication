require 'spec_helper'

describe EmailForToday do

  before(:each) { ActionMailer::Base.deliveries.clear }

  it "sends an email when there are no submissions" do
    Submission.should_receive(:today).and_return([])
    EmailForToday.new.perform
    expect(ActionMailer::Base.deliveries.size).to eq(1)
  end

  it "sends X when there are X" do
    submissions = []
    3.times do
      submissions << FactoryGirl.create(:submission)
    end
    Submission.should_receive(:today).and_return(submissions)

    EmailForToday.new.perform
    expect(ActionMailer::Base.deliveries.size).to eq(1)
  end

end