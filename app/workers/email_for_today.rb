class EmailForToday
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  def initialize(query = Submission.today)
    @query = query
  end

  def perform
    @query.each do |submission|
      TodaySubmissionsMailer.send(submission)
    end
  end
end