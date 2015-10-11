module ContractsHelper
  def link_to_contract(contract)
    link_to(h(contract.display_description), "#contract_#{contract.id}")
  end

  def new_contracts_sentence(create_versions)
    create_versions = create_versions.reject{ |v| v.item.nil? }
    if create_versions.any?
      contracts = create_versions.map {|v| link_to_contract(v.item)}
      "#{'New contract'.pluralize(contracts.count)}: #{contracts.to_sentence}.".html_safe
    end
  end
end
