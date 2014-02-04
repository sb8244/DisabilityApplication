class SubmissionsController < ApplicationController
  def index
    @submissions = Submission.all
  end

  def create
  end

  def new
  end

  def destroy
  end

  def show
    @submission = Submission.find(params[:id])
  end

  def update
    @submission = Submission.find(params[:id])
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
end
