class AddDescriptionToContractors < ActiveRecord::Migration
  def change
    add_column :contractors, :description, :text
  end
end
