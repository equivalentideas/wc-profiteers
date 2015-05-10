class AddAbnToContractors < ActiveRecord::Migration
  def change
    add_column :contractors, :abn, :string
    add_index :contractors, :abn
  end
end
