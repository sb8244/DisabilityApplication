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
        subject.should have_selector(selector, exact: submission.student_name)
        subject.should have_selector(selector, exact: submission.student_email)
        subject.should have_selector(selector, exact: submission.course_number)
        subject.should have_selector(selector, exact: submission.start_time.to_formatted_s(:long_ordinal))
        subject.should have_selector(selector, exact: submission.class_length)
        subject.should have_selector(selector, exact: submission.exam_pickup)
        subject.should have_selector(selector, exact: submission.exam_return)
        subject.should have_selector(selector, exact: submission.professor.name)
        subject.should have_selector(selector, exact: submission.professor.email)
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
    it { should have_input.for(:submission => :reader) }
    it { should have_input.for(:submission => :scribe) }
    it { should have_input.for(:submission => :laptop) }
    it { should have_selector("input[type='submit']") } 
    it { should_not have_selector(".errors") }

    it "should display errors if any" do
      errors = double(:full_messages => ['error message', 'error 2'], :any? => true)
      mock = mock_model(Submission, :id => "1", :errors => errors)
      Submission.stub(:find).with("1").and_return(mock)
      get :show, :id => "1"
      subject.should have_selector(".errors")
      subject.should =~ /error message/
      subject.should =~ /error 2/
    end

  end

  describe 'POST :update' do
    before do
      @submission = FactoryGirl.create(:submission)
      FactoryGirl.create(:submission)
    end

    context "with valid params" do 
      before(:each) do
        put :update, {id: @submission, submission: @submission.attributes}
      end
      it "assigns an updated submission as @submission" do
        assigns(:submission).should eq(@submission)
      end
      it "saves the newly created professor" do
        assigns(:submission).should be_persisted
      end
      it "redirects to the newly created professor" do
        response.should redirect_to(@submission)
      end
    end

    context "with invalid params" do
      it "renders the show page when update_attributes fails" do
        mock = mock_model(Submission, :id => @submission)
        mock.stub(:update_attributes).and_return(false)
        Submission.stub(:find).with(@submission.id.to_s).and_return(mock)
        put :update, {id: @submission, submission: @submission.attributes}
        expect(response).to render_template(:show)
      end
    end
  end

  describe 'DELETE :destroy' do
    before do
      @submission = FactoryGirl.create(:submission)
    end
    before(:each) { delete :destroy, :id => @submission.id }

    it "assigns @submission to the submission" do
      assigns(:submission).should eq(@submission)
    end

    it "destroys the @submission resource" do
      assigns(:submission).should be_destroyed
    end

    it { should redirect_to :action => :index }
  end
end
