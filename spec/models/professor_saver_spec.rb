require 'spec_helper'

describe ProfessorSaver do
  let(:valid_attributes) { FactoryGirl.attributes_for(:professor) }
  let(:professor) { Professor.new(valid_attributes) }

  it "grabs an existing professor by email" do
    professor.save!
    saver = ProfessorSaver.new(valid_attributes)
    expect(saver.get_professor).to eq(professor)
  end

  it "creates professor with name" do
    saver = ProfessorSaver.new(valid_attributes)
    saved_professor = saver.get_professor
    expect(saved_professor.name).to eq(valid_attributes[:name])
  end

  it "creates professor with email" do
    saver = ProfessorSaver.new(valid_attributes)
    saved_professor = saver.get_professor
    expect(saved_professor.email).to eq(valid_attributes[:email])
  end

end
