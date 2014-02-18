class Query::TodaySubmissions

  def initialize(relation = Submission.all)
    @relation = relation
  end

  def find_each(&block)
    beginning = DateTime.now.beginning_of_day
    ending = DateTime.now.end_of_day
    @relation.
      where("start_time > ? AND start_time < ?", beginning, ending).
      find_each(&block)
  end
end