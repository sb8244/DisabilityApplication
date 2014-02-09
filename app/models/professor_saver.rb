class ProfessorSaver

  def initialize(attributes)
    if attributes.nil? || attributes[:name].empty? || attributes[:email].empty?
      raise "Name and email are required to enter a Professor"
    end
    # Try to find a professor with the given email
    @professor = Professor.find_by_email(attributes[:email])
    # Create a new professor with the attributes name/email
    unless @professor
      @professor = Professor.create( name: attributes[:name], email: attributes[:email] )
    end
  end

  def get_professor
    @professor
  end

end