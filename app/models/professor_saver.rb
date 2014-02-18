class ProfessorSaver

  def initialize(attributes)
    # Try to find a professor with the given email
    @professor = Professor.find_by_email(attributes[:email])
    # Create a new professor with the attributes name/email
    unless @professor
      @professor = Professor.new( name: attributes[:name], email: attributes[:email] )
    end
  end

  def get_professor
    @professor
  end

end