class AddContractorRefToContracts < ActiveRecord::Migration
  def change
    add_reference :contracts, :contractor, index: true
  end
end
