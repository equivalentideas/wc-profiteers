namespace :morph do
  desc "Get contractors from morph.io api"
  task :get_contractors => :environment do
    require 'open-uri'

    url = "https://api.morph.io/equivalentideas/westconnex_contracts/data.json?key=#{ENV['MORPH_SECRET_KEY']}&query=select%20*%20from%20'contractors'"
    contractors = JSON.parse(open(url).read)

    current_count = Contractor.count
    contractors.each do |c|
      Contractor.create(
        abn: c["abn"],
        name: c["name"],
        acn: c["acn"],
        street_adress: c["street_address"],
        city: c["city"],
        state: c["state"],
        postcode: c["postcode"],
        country: c["country"]
      )
    end

    p "Created #{Contractor.count - current_count} new contractors"
  end
end
