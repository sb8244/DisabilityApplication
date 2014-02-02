class AddSubmissionIdToProfessor < ActiveRecord::Migration
  def change
    add_column :submissions, :professor_id, :integer
  end
end
