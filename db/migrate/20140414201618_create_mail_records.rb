class CreateMailRecords < ActiveRecord::Migration
  def change
    create_table :mail_records do |t|
      t.datetime :date
      t.string :to
      t.integer :submission_id

      t.timestamps
    end
  end
end
