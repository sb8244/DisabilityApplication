class EmailForToday
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  recurrence { daily.hour_of_day(6) }

  def perform
    submissions = Submission.today
    SubmissionsMailer.today(submissions).deliver
  end
end