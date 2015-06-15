class ContractorsController < ApplicationController
  def index
    @contractors = Contractor.all.sort { |a, b| b.total_est_contract_value <=> a.total_est_contract_value }
    @contractor_history = PaperTrail::Version.where("item_type = ? and event = ?", "Contractor", "create")
    @contract_history = PaperTrail::Version.where("item_type = ? and event = ?", "Contract", "create")
    @days_with_changes = PaperTrail::Version.group_by_day(:created_at).keys.map{|k| k.to_date}.reverse
  end
end
