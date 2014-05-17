require 'spec_helper'

describe DailyEmailReminder do
  subject { DailyEmailReminder.new }

  context "with a submission tomorrow" do
    before(:each) { FactoryGirl.create(:submission, start_time: DateTime.tomorrow) }

    it "sends an email" do
      expect{
        subject.perform
      }.to change{ ActionMailer::Base.deliveries.size }.by(1)
    end
  end

  context "With many submissions tomorrow" do
    before(:each) {
      FactoryGirl.create(:submission, start_time: DateTime.tomorrow)
      FactoryGirl.create(:submission, start_time: DateTime.tomorrow)
      FactoryGirl.create(:submission, start_time: DateTime.tomorrow)
    }

    it "sends multiple emails" do
      expect{
        subject.perform
      }.to change{ ActionMailer::Base.deliveries.size }.by(3)
    end
  end

  context "with no submissions tomorrow" do
    it "doesn't send an email" do
      expect{
        subject.perform
      }.not_to change{ ActionMailer::Base.deliveries.size }
    end

    it "doesn't send an email for today's submissions" do
      FactoryGirl.create(:submission, start_time: DateTime.now)
      expect{
        subject.perform
      }.not_to change{ ActionMailer::Base.deliveries.size }
    end

    it "doesn't send an email for 2 days away submissions" do
      FactoryGirl.create(:submission, start_time: DateTime.now + 2.days)
      expect{
        subject.perform
      }.not_to change{ ActionMailer::Base.deliveries.size }
    end
  end
end
