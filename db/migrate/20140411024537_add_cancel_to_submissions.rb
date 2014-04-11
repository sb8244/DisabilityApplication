class AddCancelToSubmissions < ActiveRecord::Migration
  def change
    add_column :submissions, :cancelled, :boolean, default: false
  end
end
