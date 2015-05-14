class ContractorsController < ApplicationController
  def index
    @contractors = Contractor.all.sort { |a, b| b.total_est_contract_value <=> a.total_est_contract_value }
  end
end
