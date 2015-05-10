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

  desc "Get the contracts for each contractor"
  task :get_contracts => :environment do
    require 'open-uri'
    # for each contractor
    Contractor.all.each do |contractor|
      # get the array of contracts
      # for each contract
      url = "https://api.morph.io/equivalentideas/westconnex_contracts/data.json?key=#{ENV['MORPH_SECRET_KEY']}&query=select%20contracts%20from%20'contractors'%20where%20abn%3D'#{contractor.abn}'"
      JSON.parse(open(url).read)[0]["contracts"].split(", ").each do |c|
        # go get the contract by id
        url = "https://api.morph.io/equivalentideas/westconnex_contracts/data.json?key=#{ENV['MORPH_SECRET_KEY']}&query=select%20*%20from%20'contracts'%20where%20contract_award_notice_id%3D'#{c}'"
        contract_data = JSON.parse(open(url).read)[0]
        # add the contract and associate it with the contractor
        p "Updating contact #{contract_data['contract_award_notice_id']}"
        Contract.where(can_id: contract_data["contract_award_notice_id"]).first_or_initialize do |contract|
          # If there's an ammended value, get that.
          if contract_data["amended_contract_value_est"] === nil
            v = contract_data["contract_value_est"]
          else
            v = contract_data["amended_contract_value_est"]
          end

          contract.update(
           description: contract_data["particulars_of_the_goods_or_services_to_be_provided_under_this_contract"],
           url: contract_data["url"],
           start_date: Date.parse(contract_data["contract_start_date"]),
           end_date: Date.parse(contract_data["contract_end_date"]),
           value: v,
           contractor_id: Contractor.where(abn: contract_data["abn"]).first.id
          )
        end
      end
    end
  end
end
