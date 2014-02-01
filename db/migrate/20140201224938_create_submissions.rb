class CreateSubmissions < ActiveRecord::Migration
  def change
    create_table :submissions do |t|
      t.string :student_name
      t.string :student_email
      t.string :course_number
      t.datetime :start_time
      t.integer :class_length
      t.string :exam_pickup
      t.string :exam_return
      t.boolean :reader
      t.boolean :scribe
      t.boolean :laptop

      t.timestamps
    end
  end
end
