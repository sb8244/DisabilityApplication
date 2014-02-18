class EmailForToday
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  def initialize(query = Query::TodaySubmissions.new)
    @query = query
  end

  def perform
    @query.find_each do |submission|
      TodaySubmissionsMailer.send(submission)
    end
  end
end