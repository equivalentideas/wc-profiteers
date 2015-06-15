class ContractorsController < ApplicationController
  def index
    @contractors = Contractor.all.sort { |a, b| b.total_est_contract_value <=> a.total_est_contract_value }
    @contractor_history = PaperTrail::Version.where("created_at > ? and item_type = ? and event = ?", 2.week.ago, "Contractor", "create")
    @contract_history = PaperTrail::Version.where("created_at > ? and item_type = ? and event = ?", 2.week.ago, "Contract", "create")
    @days_with_changes = PaperTrail::Version.group_by_day(:created_at).keys.map{|k| k.to_date}.reverse
  end
end
