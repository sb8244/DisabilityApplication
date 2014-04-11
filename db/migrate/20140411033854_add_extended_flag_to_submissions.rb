class AddExtendedFlagToSubmissions < ActiveRecord::Migration
  def change
    add_column :submissions, :extended, :boolean, default: true
    add_column :submissions, :extended_amount, :integer
  end
end
