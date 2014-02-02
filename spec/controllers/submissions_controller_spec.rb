require 'spec_helper'

describe SubmissionsController do

  describe 'GET :index' do
    render_views
    before do
      @submissions_list = [
        FactoryGirl.create(:submission),
        FactoryGirl.create(:submission)
      ]
    end

    it "should have a table of submissions" do
      get :index, :format => "html"
      response.body.should have_selector("table")
      @submissions_list.each_with_index do |submission, i|
        selector = "table > tbody > tr:nth-child(#{i+1}) > td"
        response.body.should have_selector(selector, exact: submission.student_name)
        response.body.should have_selector(selector, exact: submission.student_email)
        response.body.should have_selector(selector, exact: submission.course_number)
        response.body.should have_selector(selector, exact: submission.start_time.to_formatted_s(:long_ordinal))
        response.body.should have_selector(selector, exact: submission.class_length)
        response.body.should have_selector(selector, exact: submission.exam_pickup)
        response.body.should have_selector(selector, exact: submission.exam_return)
        response.body.should have_selector(selector, exact: submission.professor.name)
        response.body.should have_selector(selector, exact: submission.professor.email)
      end
    end

  end

  describe 'GET :show' do
    render_views
    before do 
      @submission = FactoryGirl.create(:submission)
    end
    it "should have a form" do
      get :show, :id => @submission.id
      response.body.should have_selector("form")
    end
  end

end
