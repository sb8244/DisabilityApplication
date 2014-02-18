class EmailForToday
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  def perform
    Query::TodaySubmissions.new.find_each do |submission|
      puts submission.inspect
    end
  end
end