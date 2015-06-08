module ContractorsHelper
  def simple_url(url)
    url.sub(/^https*:\/\//, '').sub('www.', '').sub(/\/\S*$/, '')
  end

  def contractor_link_by_id(id)
    link_to(h(Contractor.find(id).name), "##{h(Contractor.find(id).abn)}")
  end

  def new_contractors_sentence(create_versions)
    contractors = create_versions.map {|v| contractor_link_by_id(v.item_id)}
    return "#{'New contractor'.pluralize(contractors.count)} #{contractors.to_sentence} added.".html_safe
  end
end
