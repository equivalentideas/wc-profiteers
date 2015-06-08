class ContractorsController < ApplicationController
  def index
    @contractors = Contractor.all.sort { |a, b| b.total_est_contract_value <=> a.total_est_contract_value }
    @contractor_history = PaperTrail::Version.where("created_at > ? and item_type = ? and event = ?", 2.week.ago, "Contractor", "create")
    @last_two_weeks = (2.weeks.ago.to_date..Date.today).to_a.reverse
  end
end
