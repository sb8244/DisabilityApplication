class ProfessorsController < ApplicationController
  respond_to :json, :html

  # Gets a list of professors either like name, like email, or all
  def list
    if params[:name]
      @professors = Professor.like_name(params[:name])
    elsif params[:email]
      @professors = Professor.like_email(params[:email])
    else
      @professors = Professor.all
    end

    respond_to do |format|
      format.json { render json: @professors }
      format.html
    end
  end

  private
    def professor_params
      params.require(:professor).permit(:name, :email)
    end

end
