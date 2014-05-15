class AddTestLengthsToSubmissions < ActiveRecord::Migration
  def up
    remove_column :submissions, :extended_amount
    remove_column :submissions, :class_length
    add_column :submissions, :actual_test_length, :integer
    add_column :submissions, :student_test_length, :integer
  end

  def down
    add_column :submissions, :extended_amount, :integer
    add_column :submissions, :actual_test_length, :integer
    remove_column :submissions, :student_test_length
    remove_column :submissions, :class_length
  end
end
