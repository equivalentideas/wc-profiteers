module ContractsHelper
  def link_to_contract_by_id(id)
    link_to(h(Contract.find(id).description), "##{h(Contract.find(id).can_id)}")
  end
end
