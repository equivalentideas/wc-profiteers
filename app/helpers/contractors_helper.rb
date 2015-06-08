module ContractorsHelper
  def simple_url(url)
    url.sub(/^https*:\/\//, '').sub('www.', '').sub(/\/\S*$/, '')
  end

  def new_contractors_sentence(create_versions)
    contractors = create_versions.map {|v| content_tag(:em, h(Contractor.find(v.item_id).name))}
    return "#{'New contractor'.pluralize(contractors.count)} #{contractors.to_sentence} added.".html_safe
  end
end
