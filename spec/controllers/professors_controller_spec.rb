require 'spec_helper'

describe ProfessorsController do
  
  # login to http basic auth
  before(:each) do
    http_login
  end

  describe "GET :list" do 
    render_views
    before do
      @professors_list = [
        FactoryGirl.create(:professor),
        FactoryGirl.create(:professor)
      ]
    end

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

=begin This create method was removed because it may not be needed
  describe "POST :create" do

    before do
      @valid_attributes = FactoryGirl.build(:professor).attributes
    end

    context "with valid params" do 
      before(:each) do
        post :create, { professor: @valid_attributes }, :format => "json"
      end
      it "assigns a newly created professor as @professor" do
        assigns(:professor).should be_a(Professor)
      end
      it "saves the newly created professor" do
        assigns(:professor).should be_persisted
      end
      it "redirects to the newly created professor" do
        response.should redirect_to(Professor.last)
      end
    end

    context "with invalid params" do
      before do
        Professor.any_instance.stub(:save).and_return(false)
        post :create, { professor: @valid_attributes }
      end
      it "assigns a newly created but unsaved professor as @professor" do
        assigns(:profressor).should be_a_new(Professor)
      end
      it "re-renders the :new template" do
        response.should render_template("new")
      end
    end

  end
=end
end
