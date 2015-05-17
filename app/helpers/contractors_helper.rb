module ContractorsHelper
  def simple_url(url)
    url.sub(/^https*:\/\//, '').sub('www.', '').sub(/\/\S*$/, '')
  end
end
