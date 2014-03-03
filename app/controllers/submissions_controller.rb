class SubmissionsController < ApplicationController
  def index
    # Grab a date that is either today or the date passed in
    @date = Date.today
    @date = Date.parse(params[:date]) unless params[:date].blank?
    @submissions = Submission.find_in_date(@date.beginning_of_day, @date.end_of_day)
    @previous_day = @date.advance(days: -1)
    @next_day = @date.advance(days: 1)
  end

  def all
    @submissions = Submission.order("start_time ASC").all
  end

  def create
    @submission = Submission.new(submission_params)
    @professor = ProfessorSaver.new(professor_params).get_professor
    if @professor.save
      @submission.professor = @professor
      if @submission.save
        flash[:notice] = "Submission created successfully"
        return redirect_to @submission
      end
    else
      @submission.professor = Professor.new
      @submission.errors.add(:professor, "email is required") if professor_params[:email].empty?
      @submission.errors.add(:professor, "name is required") if professor_params[:name].empty?
      professor_success = false
    end  

    render :new
  end

  def new
    @submission = Submission.new
    @submission.professor = Professor.new
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

    professor = ProfessorSaver.new(professor_params).get_professor
    if professor.save
      @submission.professor = professor
      if @submission.update_attributes(submission_params)
        flash[:notice] = "Submission updated successfully"
        return redirect_to @submission
      end
    else
      @submission.errors.add(:professor, "email is required") if professor_params[:email].empty?
      @submission.errors.add(:professor, "name is required") if professor_params[:name].empty?
      professor_success = false
    end    

    render :show
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