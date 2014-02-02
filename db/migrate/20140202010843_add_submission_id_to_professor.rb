class AddSubmissionIdToProfessor < ActiveRecord::Migration
  def change
    add_column :professors, :submission_id, :integer
    add_column :submissions, :professor_id, :integer
  end
end
