class ProfessorFactory
  def self.get_valid
    Professor.new(
      name: "Test",
      email: "test@test.com"
    )
  end
end
