class ChangeAcnTypeInContractors < ActiveRecord::Migration
  def self.up
    change_column :contractors, :acn, :string
  end

  def self.down
    change_column :contractors, :acn, :integer
  end
end
