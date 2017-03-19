class ProfessorRepository
  def self.set_adapter(adapter)
    raise if @adapter.present?
    @adapter = adapter
  end

  def self.all
    @adapter.all
  end
end
