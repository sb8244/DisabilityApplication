class EmailForToday
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  # This is going as UTC, so add 5 hours to offset the EST timezone difference
  recurrence { daily.hour_of_day(6+5) }

  def perform
    submissions = Submission.today
    SubmissionsMailer.today(submissions).deliver
  end
end
