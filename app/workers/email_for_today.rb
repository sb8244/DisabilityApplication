class EmailForToday
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  def perform
    submissions = Submission.today
    SubmissionsMailer.today(submissions).deliver
  end
end