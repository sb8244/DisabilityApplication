class SubmissionRepository < Repository
  def self.one(id)
    @adapter.one(id: id)
  end
end
