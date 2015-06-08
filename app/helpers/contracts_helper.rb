module ContractsHelper
  def link_to_contract_by_id(id)
    link_to(h(Contract.find(id).display_description), "##{h(Contract.find(id).can_id)}")
  end

  def new_contracts_sentence(create_versions)
    contracts = create_versions.map {|v| link_to_contract_by_id(v.item_id)}
    return "#{'New contract'.pluralize(contracts.count)}: #{contracts.to_sentence}.".html_safe
  end
end
