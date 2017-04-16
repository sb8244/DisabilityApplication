require "core_helper"

RSpec.describe ProfessorRepository do
  describe ".all" do
    it "only hits the adapter without any arguments" do
      expect(test_adapter).to receive(:all).once.and_return([1, 2, 3])
      expect(ProfessorRepository.all).to eq([1, 2, 3])
    end

    it "uses like_name query when like_name is passed" do
      query_mock = double
      expect(query_mock).to receive(:call).once.with([1, 2, 3]).and_return([1, 2])
      expect(ProfessorRepository.get_queries).to receive(:like_name).once.with("test").and_return(query_mock)
      expect(test_adapter).to receive(:all).once.and_return([1, 2, 3])
      ProfessorRepository.all(like_name: "test")
    end

    it "uses like_email query when like_email is passed" do
      query_mock = double
      expect(query_mock).to receive(:call).once.with([1, 2, 3]).and_return([1, 2])
      expect(ProfessorRepository.get_queries).to receive(:like_email).once.with("t").and_return(query_mock)
      expect(test_adapter).to receive(:all).once.and_return([1, 2, 3])
      ProfessorRepository.all(like_email: "t")
    end

    it "can combine queries" do
      email_query_mock = double
      name_query_mock = double
      expect(name_query_mock).to receive(:call).once.with([1, 2, 3]).and_return([1, 2])
      expect(email_query_mock).to receive(:call).once.with([1, 2]).and_return([1])
      expect(ProfessorRepository.get_queries).to receive(:like_email).once.with("t").and_return(email_query_mock)
      expect(ProfessorRepository.get_queries).to receive(:like_name).once.with("name").and_return(name_query_mock)
      expect(test_adapter).to receive(:all).once.and_return([1, 2, 3])
      expect(ProfessorRepository.all(like_email: "t", like_name: "name")).to eq([1])
    end
  end
end
