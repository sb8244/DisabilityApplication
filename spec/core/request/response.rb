require "core_helper"

RSpec.describe Response do
  subject(:response) { Response.new }

  describe "initial state" do
    it "is successful" do
      expect(response.success?).to eq(true)
      expect(response.error?).to eq(false)
    end

    it "has no view attributes" do
      expect(response.view).to eq(nil)
    end

    it "has no error reason" do
      expect(response.error_reason).to eq(nil)
    end
  end

  describe "set_error" do
    it "returns self" do
      expect(response.set_error(type: :invalid_data)).to eq(response)
    end

    it "requires a reason in the error set" do
      expect { response.set_error(type: :nope) }.to raise_error(ArgumentError, "type is not valid")
    end

    it "return true for error? after" do
      response.set_error(type: :invalid_data)
      expect(response.success?).to eq(false)
      expect(response.error?).to eq(true)
    end

    it "can optionally set the reason" do
      response.set_error(type: :invalid_data, reason: "Name is required")
      expect(response.error_reason).to eq("Name is required")
    end
  end

  describe "view=" do
    it "can set view to the given input" do
      response.view = OpenStruct.new(test: true)
      expect(response.view.test).to eq(true)
    end
  end
end
