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
    before(:each) { get :index, :format => "html" }
    subject { response.body }

    it { should have_selector("table") }
    it "should have a row for each entry" do
      @submissions_list.each_with_index do |submission, i|
        selector = "table > tbody > tr:nth-child(#{i+1}) > td"
        expect(subject).to have_selector(selector, exact: submission.student_name)
        expect(subject).to have_selector(selector, exact: submission.student_email)
        expect(subject).to have_selector(selector, exact: submission.course_number)
        expect(subject).to have_selector(selector, exact: submission.start_time.to_formatted_s(:long_ordinal))
        expect(subject).to have_selector(selector, exact: submission.class_length)
        expect(subject).to have_selector(selector, exact: submission.exam_pickup)
        expect(subject).to have_selector(selector, exact: submission.exam_return)
        expect(subject).to have_selector(selector, exact: submission.professor.name)
        expect(subject).to have_selector(selector, exact: submission.professor.email)
      end
    end
  end

  describe 'GET :show' do
    render_views

    before(:each) { get :show, :id => FactoryGirl.create(:submission).id }
    subject { response.body }

    it { should have_form }
    it { should have_input.for(:submission => :student_name) }
    it { should have_input.for(:submission => :student_email) }
    it { should have_input.for(:submission => :course_number) }
    it { should have_input.for(:submission => :start_time) }
    it { should have_input.for(:submission => :class_length) }
    it { should have_input.for(:submission => :exam_pickup) }
    it { should have_input.for(:submission => :exam_return) }
    it { should have_selector("input[type='submit']") } 
  end

end
