class SubmissionRepository < Repository
  def self.one(id)
    @adapter.one(id)
  end
end
