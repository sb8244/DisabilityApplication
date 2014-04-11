class AddLaptopReasonToSubmissions < ActiveRecord::Migration
  def change
    add_column :submissions, :laptop_reason, :string
  end
end
