class SubmissionsController < ApplicationController
  def index
    # Grab a date that is either today or the date passed in
    @date = Date.today
    @date = Date.parse(params[:date]) unless params[:date].blank?
    @submissions = Submission.find_in_date(@date.beginning_of_day, @date.end_of_day)
    @previous_day = @date.advance(days: -1)
    @next_day = @date.advance(days: 1)
  end

  def create
  end

  def new
  end

  def destroy
    @submission = Submission.find(params[:id])
    @submission.destroy
    flash[:notice] = "Submission #{params[:id]} deleted"
    redirect_to :action => :index
  end

  def show
    @submission = Submission.find(params[:id])
  end

  def update
    @submission = Submission.find(params[:id])
    begin
      professor_saver = ProfessorSaver.new(professor_params)
      @submission.professor = professor_saver.get_professor
    rescue 
      @submission.errors.add(:professor, "email is required") if professor_params[:email].empty?
      @submission.errors.add(:professor, "name is required") if professor_params[:name].empty?
      return render :show
    end

    if @submission.update_attributes(submission_params)
      flash[:notice] = "Submission updated successfully"
      redirect_to @submission
    else
      render :show
    end
  end

  private
    def submission_params
      params.require(:submission).permit(:student_name, :student_email, :course_number, :start_time,
        :class_length, :exam_pickup, :exam_return, :reader, :scribe, :laptop)
    end

    def professor_params
      params.require(:submission).permit(professor: [:name, :email])[:professor]
    end
end