# Send an email reminder for all exams which are scheduled for TOMORROW
# Runs at 6 am daily, so will remind for Thursday exams if run at 6am Wednesday
class DailyEmailReminder
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  # This is going as UTC, so add 5 hours to offset the EST timezone difference
  recurrence { daily.hour_of_day(6+5) }

  def perform
    submissions = Submission.tomorrow # .today if you don't want it to be tomorrow, OR send both
    submissions.each do |submission|
      SubmissionsMailer.reminder(submission).deliver
    end
  end
end
