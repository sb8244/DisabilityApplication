require 'spec_helper'

describe SubmissionsController do
  render_views
  before(:each) { http_login }
  let(:submission) { FactoryGirl.create(:submission) }

  describe 'GET :index' do
    let!(:submissions_list) { [FactoryGirl.create(:submission), FactoryGirl.create(:submission)] }

    describe "without custom date" do
      before(:each) { get :index, :format => "html" }
      subject { response.body }

      it { should have_selector("table") }
      it "should have a row for each entry" do
        submissions_list.each_with_index do |submission, i|
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

    describe "with date" do
      before { submissions_list[0].start_time + 1.days }
      before(:each) { get :index, format: "html", date: Date.today }
      it { expect(assigns(:date)).to eq(Date.today) }
      it { expect(assigns(:next_day)).to eq(Date.today + 1.days)}
      it { expect(assigns(:previous_day)).to eq(Date.today - 1.days)}
    end
  end

  describe 'GET :show' do
    before(:each) { get :show, :id => submission.id }
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
    it { should have_input.for('submission[professor]' => :name) }
    it { should have_input.for('submission[professor]' => :email) }
    it { should have_selector("input[type='submit']") } 
    it { should_not have_selector(".errors") }

    it "should display errors if any" do
      errors = double(:full_messages => ['error message', 'error 2'], :any? => true)
      mock = mock_model(Submission, :id => "1", :errors => errors, :professor => FactoryGirl.create(:professor))
      Submission.stub(:find).with("1").and_return(mock)
      get :show, :id => "1"
      subject.should have_selector(".errors")
      subject.should =~ /error message/
      subject.should =~ /error 2/
    end

  end

  describe 'POST :update' do
    let(:professor_attributes) { { professor: FactoryGirl.attributes_for(:professor) } }
    before { FactoryGirl.create(:submission) }

    context "with valid params" do 
      before(:each) do
        put :update, { id: submission, submission: submission.attributes.merge(professor_attributes) }
      end
      it "assigns an updated submission as @submission" do
        assigns(:submission).should eq(submission)
      end
      it "saves the newly created professor" do
        assigns(:submission).should be_persisted
      end
      it "redirects to the newly created professor" do
        response.should redirect_to(submission)
      end
    end

    context "with invalid params" do
      it "renders the show page when update_attributes fails" do
        submission.student_email = ""
        put :update, {id: submission, submission: submission.attributes.merge(professor_attributes)}
        expect(response).to render_template(:show)
      end
      it "renders error when professor name is empty" do
        professor_attributes[:professor][:name] = ""
        put :update, {id: submission, submission: submission.attributes.merge(professor_attributes)}
        expect(response).to render_template(:show)
      end
      it "renders error when professor email is empty" do
        professor_attributes[:professor][:email] = ""
        put :update, {id: submission, submission: submission.attributes.merge(professor_attributes)}
        expect(response).to render_template(:show)
      end
    end
  end

  describe 'DELETE :destroy' do
    before(:each) { delete :destroy, :id => submission.id }

    it "assigns @submission to the submission" do
      assigns(:submission).should eq(submission)
    end

    it "destroys the @submission resource" do
      assigns(:submission).should be_destroyed
    end
  end

  describe 'POST :reschedule' do
    let!(:submission) { FactoryGirl.create(:submission) }
    it "cancels the submission" do
      expect{ 
        post :reschedule, id: submission.id
        submission.reload
      }.to change{ submission.cancelled? }.from(false).to(true)
    end

    it "adds a new submission" do
      expect {
        post :reschedule, id: submission.id
      }.to change{ Submission.count }.by(1)
    end

    it "removes the new submission's date" do
      post :reschedule, id: submission.id
      expect(Submission.last.start_time).to be(nil)
    end

    it "redirects to the new submission" do
      post :reschedule, id: submission.id
      expect(response).to redirect_to(Submission.last)
    end

    it "sends a mail" do
      expect {
        post :reschedule, id: submission.id
      }.to change{ ActionMailer::Base.deliveries.count }.by(1)
    end
  end

  describe 'POST :create' do
    let!(:submission) { FactoryGirl.create(:submission) }
    it "creates a submission" do
      expect {
        post :create, submission: submission_attributes(submission)
      }.to change{ Submission.count }.by(1)
    end

    it "creates a new professor if it doesn't exist" do
      submission.professor.delete
      expect {
        post :create, submission: submission_attributes(submission)
      }.to change{ Professor.count }.by(1)
    end

    it "sends mail" do
      expect {
        post :create, submission: submission_attributes(submission)
      }.to change{ ActionMailer::Base.deliveries.count }.by(1)
    end
  end

  def submission_attributes(submission)
    { professor: { name: submission.professor.name, email: submission.professor.email } }.merge(submission.attributes)
  end
end
