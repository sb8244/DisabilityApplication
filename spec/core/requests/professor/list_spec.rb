require "core_helper"

RSpec.describe ProfessorListRequest do
  describe "without an authorized session" do
    subject do
      session = Session.new
      ProfessorListRequest.new(session: session, params: {})
    end

    it "raises an NotAuthorizedError" do
      expect {
        subject.call
      }.to raise_error(Request::NotAuthorizedError)
    end
  end

  describe "with an authorized session" do
    let(:params) {{}}

    subject do
      session = Session.new.authorized!
      ProfessorListRequest.new(session: session, params: params)
    end

    describe "without any params" do
      it "returns a successful response containing all professors" do
        professors = [ProfessorFactory.get_valid, ProfessorFactory.get_valid]
        expect(ProfessorRepository).to receive(:all).with(like_name: nil, like_email: nil).once.and_return(professors)
        response = subject.call
        expect(response.success?).to eq(true)
        expect(response.view.professors).to eq(professors)
      end
    end

    describe "with name param" do
      let(:params) { { name: 'test' } }

      it "fetches professors like that name" do
        professors = [ProfessorFactory.get_valid, ProfessorFactory.get_valid]
        expect(ProfessorRepository).to receive(:all).with(like_name: 'test', like_email: nil).once.and_return(professors)
        response = subject.call
        expect(response.success?).to eq(true)
        expect(response.view.professors).to eq(professors)
      end
    end

    describe "with email param" do
      let(:params) { { email: 'test@t' } }

      it "fetches professors like that email" do
        professors = [ProfessorFactory.get_valid, ProfessorFactory.get_valid]
        expect(ProfessorRepository).to receive(:all).with(like_name: nil, like_email: 'test@t').once.and_return(professors)
        response = subject.call
        expect(response.success?).to eq(true)
        expect(response.view.professors).to eq(professors)
      end
    end
  end
end
