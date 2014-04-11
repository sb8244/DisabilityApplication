class AddNoShowToSubmissions < ActiveRecord::Migration
  def change
    add_column :submissions, :no_show, :boolean, default: false
  end
end
