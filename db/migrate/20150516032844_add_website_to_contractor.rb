class AddWebsiteToContractor < ActiveRecord::Migration
  def change
    add_column :contractors, :website, :string
  end
end
