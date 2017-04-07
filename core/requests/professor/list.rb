class ProfessorListRequest < Request
  def request
    authorized!
    professors = ProfessorRepository.all(like_name: params[:name], like_email: params[:email])
    response.view = OpenStruct.new(professors: professors)
  end
end
