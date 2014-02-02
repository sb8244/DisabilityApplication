require 'spec_helper'

describe ProfessorController do
  render_views
  before {
    @professors_list = [
      FactoryGirl.create(:professor),
      FactoryGirl.create(:professor)
    ]
  }

  it "gets a list of all professors as a json array" do
    get :list, :format => "json"
    response.body.should eq(@professors_list.to_json)
  end

  it "gets a list of all professors like name as a json array" do
    get :list, :name => @professors_list[0].name[0..10], :format => "json"
    response.body.should eq([@professors_list[0]].to_json)
  end

  it "gets a list of all professors like email as a json array" do
    get :list, :email => @professors_list[1].email[0..10], :format => "json"
    response.body.should eq([@professors_list[1]].to_json)
  end

  it "gets a list of all professors as an html table" do
    get :list, :format => "html"
    response.body.should have_selector("table")
    #Each professor in our list should have a td with their content, at a minimum
    @professors_list.each do |professor|
      response.body.should have_selector("table > tbody > tr > td", exact: professor.name)
      response.body.should have_selector("table > tbody > tr > td", exact: professor.email)
    end
  end
end
