require "core_helper"

class View
  def initialize(attributes = {})
    @attributes = attributes
  end

  def method_missing(method, *args)
    @attributes[method] unless method.to_s.include?('=')
  end
end

class ProfessorListRequest < Request
  def call
    authorized!
    View.new(professors: ProfessorRepository.all)
  end
end

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
      it "returns a view containing all professors" do
        professors = [ProfessorFactory.get_valid, ProfessorFactory.get_valid]
        expect(test_adapter).to receive(:all).once.and_return(professors)
        view = subject.call
        expect(view.professors).to eq(professors)
      end
    end

    describe "with name param" do
      it "fetches professors like that name"
    end

    describe "with email param" do
      it "fetches professors like that email"
    end
  end
end
