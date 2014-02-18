require 'spec_helper'

describe Query::TodaySubmissions do

  it "gets a submission for today" do
    expected = FactoryGirl.create(:submission)

    Query::TodaySubmissions.new.find_each do |submission|
      expect(submission).to eq(expected)
    end
  end

  it "gets all submissions for today" do
    expected = FactoryGirl.create(:submission)
    expected2 = FactoryGirl.create(:submission)

    submissions = []
    Query::TodaySubmissions.new.find_each do |submission|
      submissions << submission
    end
    expect(submissions[0]).to eq(expected)
    expect(submissions[1]).to eq(expected2)
  end

  it "gets a submission for today ignoring yesterday and tomorrow" do
    expected = FactoryGirl.create(:submission)
    previous = FactoryGirl.build(:submission)
    future = FactoryGirl.build(:submission)

    previous.start_time = DateTime.now - 1.days
    future.start_time = DateTime.now + 1.days
    previous.save!
    future.save!

    Query::TodaySubmissions.new.find_each do |submission|
      expect(submission).to eq(expected)
    end
  end
  
end