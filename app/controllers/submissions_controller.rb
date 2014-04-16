class SubmissionsController < ApplicationController
  def index
    # Grab a date that is either today or the date passed in
    @date = Date.today
    @date = Date.parse(params[:date]) unless params[:date].blank?
    @submissions = Submission.find_in_date(@date.beginning_of_day, @date.end_of_day).order("start_time ASC")
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
        ConfirmationMailer.do_mail(@submission.id).deliver
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

    # Just go back to where we came from
    redirect_to request.referer || :submissions
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

  def reschedule
    submission = Submission.find(params[:id])
    new_submission = submission.dup

    submission.update_attributes!(cancelled: true)
    new_submission.start_time = nil
    new_submission.save!

    redirect_to new_submission, notice: "Submission #{submission.id} was cancelled. You are rescheduling the submision now."
  end

  def email
    submission = Submission.find(params[:id])
    ConfirmationMailer.do_mail(params[:id]).deliver
    redirect_to submission, notice: "Email delivered to student and professor."
  end

  private
    def submission_params
      params.require(:submission).permit(:student_name, :student_email, :course_number, :start_time,
        :class_length, :exam_pickup, :exam_return, :reader, :scribe, :laptop, :laptop_reason, :no_show, :cancelled,
        :extended, :extended_amount)
    end

    def professor_params
      params.require(:submission).permit(professor: [:name, :email])[:professor]
    end
end