require "core_helper"

RSpec.describe SubmissionUpdateRequest do
  describe "with an authorized session" do
    def get_request(params)
      session = Session.new.authorized!
      SubmissionUpdateRequest.new(session: session, params: params)
    end

    it "looks up the submission by id" do
      allow(SubmissionRepository).to receive(:save).and_return(true)
      allow(ProfessorRepository).to receive(:one).and_return(Professor.new)
      mock_submission = Submission.new
      expect(SubmissionRepository).to receive(:one).once.with(1).and_return(mock_submission)
      response = get_request(id: 1, professor: { email: "test@test.edu" }, submission: {}).call

      expect(response.success?).to eq(true)
      expect(response.view.submission).to eq(mock_submission)
    end

    it "sets the submission professor based on their email" do
      submission = Submission.new
      professor = Professor.new
      expect(SubmissionRepository).to receive(:one).once.with(1).and_return(submission)
      expect(ProfessorRepository).to receive(:one).once.with(email: "test@test.edu").and_return(professor)
      expect(SubmissionRepository).to receive(:save).once.with(submission).and_return(true)
      response = get_request(id: 1, professor: { email: "test@test.edu" }, submission: {}).call

      expect(response.success?).to eq(true)
      expect(response.view.submission.professor).to eq(professor)
    end

    it "creates a new professor if one isn't found by email" do
      submission = Submission.new
      professor = Professor.new
      expect(SubmissionRepository).to receive(:one).once.with(1).and_return(submission)
      expect(ProfessorRepository).to receive(:one).once.with(email: "test@test.edu").and_return(nil)
      expect(ProfessorRepository).to receive(:create).once.with(instance_of(Professor)).and_return(professor)
      expect(SubmissionRepository).to receive(:save).once.with(submission).and_return(true)
      response = get_request(id: 1, professor: { email: "test@test.edu", name: "test" }, submission: {}).call

      expect(response.success?).to eq(true)
      expect(response.view.submission.professor).to eq(professor)
    end

    it "can update specific attributes" do
      all_params = {
        student_name: "Steve Bussey",
        student_email: "steve@test.com",
        course_number: "CS101",
        start_time: Time.current,
        exam_pickup: "Student",
        exam_return: "Student",
        reader: true,
        scribe: true,
        laptop: true,
        laptop_reason: "testing",
        no_show: true,
        cancelled: true,
        extended: true,
        actual_test_length: 60,
        student_test_length: 90
      }

      submission = Submission.new
      professor = Professor.new
      expect(SubmissionRepository).to receive(:one).once.with(1).and_return(submission)
      expect(ProfessorRepository).to receive(:one).once.with(email: "test@test.edu").and_return(professor)
      expect(SubmissionRepository).to receive(:save).once.with(submission).and_return(true)

      response = get_request(id: 1, professor: { email: "test@test.edu" }, submission: all_params).call
      expect(response).to be_success
      all_params.each do |param, value|
        expect(response.view.submission.send(param)).to eq(value)
      end
    end

    context "with a failed submission save" do
      it "errors the request as invalid_data" do
        allow(SubmissionRepository).to receive(:save).and_return(false)
        allow(ProfessorRepository).to receive(:one).and_return(Professor.new)
        mock_submission = Submission.new
        expect(SubmissionRepository).to receive(:one).once.with(1).and_return(mock_submission)
        response = get_request(id: 1, professor: { email: "test@test.edu" }, submission: {}).call

        expect(response.error?).to eq(true)
        expect(response.status).to eq(:invalid_data)
        expect(response.view).to eq(nil)
      end
    end

    context "with a failed professor creation" do
      it "sets an error for the required params" do
        expect(SubmissionRepository).to receive(:one).once.with(1).and_return(Submission.new)
        response = get_request(id: 1, professor: {}, submission: {}).call
        expect(response.error?).to eq(true)
        expect(response.view.errors).to eq(professor: ["Name can't be blank", "Email can't be blank", "Email is not an email"])
      end

      it "sets an error when email is invalid" do
        expect(SubmissionRepository).to receive(:one).once.with(1).and_return(Submission.new)
        response = get_request(id: 1, professor: { name: "Test", email: "t" }, submission: {}).call
        expect(response.error?).to eq(true)
        expect(response.view.errors).to eq(professor: ["Email is not an email"])
      end
    end

    describe "with a not found submission" do
      it "errors the request as not_found" do
        expect(SubmissionRepository).to receive(:one).once.with(1).and_return(nil)
        response = get_request(id: 1).call

        expect(response.error?).to eq(true)
        expect(response.status).to eq(:not_found)
        expect(response.view).to eq(nil)
      end
    end
  end
end
