class AddAbnToContractors < ActiveRecord::Migration
  def change
    add_column :contractors, :abn, :integer
    add_index :contractors, :abn
  end
end
