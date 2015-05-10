namespace :morph do
  desc "Get contractors from morph.io api"
  task :get_contractors => :environment do
    require 'open-uri'

    url = "https://api.morph.io/equivalentideas/westconnex_contracts/data.json?key=#{ENV['MORPH_SECRET_KEY']}&query=select%20*%20from%20'contractors'"
    contractors = JSON.parse(open(url).read)

    p "Found #{contractors.count} contractors"
  end
end
