require 'spec_helper'

describe Professor do
  before {
    @professor = Professor.new(
      name: "Carol Wellington",
      email: "cawell@ship.edu"
    )
  }

  subject { @professor }

  it { should respond_to(:name) }
  it { should respond_to(:email) }

  describe "when name is not present" do
    before { @professor.name = " " }
    it { should_not be_valid }
  end
end
