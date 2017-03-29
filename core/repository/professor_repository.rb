class ProfessorRepository
  def self.set_adapter(adapter)
    raise if @adapter.present?
    @adapter = adapter
  end

  def self.set_queries(queries)
    raise if @queries.present?
    @queries = queries
  end

  def self.get_queries
    @queries
  end

  def self.all(like_name: nil, like_email: nil)
    queries = []
    queries << @queries.like_name(like_name) unless like_name.nil?
    queries << @queries.like_email(like_email) unless like_email.nil?
    queries.reduce(@adapter.all) do |results, query|
      query.call(results)
    end
  end

  class Queries
    def like_name(name) ; raise NotImplementError ; end
    def like_email(email) ; raise NotImplementError ; end
  end
end
