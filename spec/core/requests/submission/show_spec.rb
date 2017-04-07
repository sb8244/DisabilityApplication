require "core_helper"

RSpec.describe SubmissionShowRequest do
  describe "without an authorized session" do
    subject do
      session = Session.new
      SubmissionShowRequest.new(session: session, params: {})
    end

    it "raises an NotAuthorizedError" do
      expect {
        subject.call
      }.to raise_error(Request::NotAuthorizedError)
    end
  end

  describe "with an authorized session" do
    def get_request(params)
      session = Session.new.authorized!
      SubmissionShowRequest.new(session: session, params: params)
    end

    it "looks up the submission by id" do
      mock_submission = double(Submission)
      expect(SubmissionRepository).to receive(:one).once.with(1).and_return(mock_submission)
      response = get_request(id: 1).call
      expect(response.success?).to eq(true)
      expect(response.view.submission).to eq(mock_submission)
    end

    describe "with a not found model" do
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
