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
end
