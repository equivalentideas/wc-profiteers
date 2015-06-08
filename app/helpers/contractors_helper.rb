module ContractorsHelper
  def simple_url(url)
    url.sub(/^https*:\/\//, '').sub('www.', '').sub(/\/\S*$/, '')
  end

  def new_contractors_sentence(create_versions)
    contractors = create_versions.map {|v| link_to(h(Contractor.find(v.item_id).name), "##{h(Contractor.find(v.item_id).abn)}")}
    return "#{'New contractor'.pluralize(contractors.count)} #{contractors.to_sentence} added.".html_safe
  end
end
