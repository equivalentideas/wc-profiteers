class ContractorsController < ApplicationController
  def index
    @contractors = Contractor.all.sort { |a, b| b.total_est_contract_value <=> a.total_est_contract_value }
    @contractor_history = PaperTrail::Version.where("item_type = ? and event = ?", "Contractor", "create")
    @contract_history = PaperTrail::Version.where("item_type = ? and event = ?", "Contract", "create")

    @contract_count = Contract.count
    @contract_total_value = Contract.sum(:value)

    # create a Array of days with contracts/contractors created or value changed.
    @days_with_changes = @contractor_history.group_by_day(:created_at).keys.map{|k| k.to_date}
    @days_with_changes += @contract_history.group_by_day(:created_at).keys.map{|k| k.to_date}
    @days_with_changes = @days_with_changes.uniq.sort { |a,b| b <=> a }[0..2]
  end
end
