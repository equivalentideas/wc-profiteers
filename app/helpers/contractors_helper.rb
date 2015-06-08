module ContractorsHelper
  def simple_url(url)
    url.sub(/^https*:\/\//, '').sub('www.', '').sub(/\/\S*$/, '')
  end

  def link_to_contractor_by_id(id)
    link_to(h(Contractor.find(id).name), "##{h(Contractor.find(id).abn)}")
  end

  def new_contractors_sentence(create_versions)
    contractors = create_versions.map {|v| link_to_contractor_by_id(v.item_id)}
    return "#{'New contractor'.pluralize(contractors.count)}: #{contractors.to_sentence}.".html_safe
  end
end
