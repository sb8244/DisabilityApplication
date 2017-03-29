class ProfessorListRequest < Request
  def call
    authorized!
    professors = ProfessorRepository.all(like_name: params[:name], like_email: params[:email])
    View.new(professors: professors)
  end
end
