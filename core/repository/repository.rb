class Repository
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
end
