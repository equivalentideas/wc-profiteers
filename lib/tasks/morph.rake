namespace :morph do
  desc "Get contractors from morph.io api"
  task :get_contractors => :environment do
    current_count = Contractor.count
    Contractor.import_contractors_from_morph
    puts "Created #{Contractor.count - current_count} new contractors"
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
        p "updating #{contract_data["contract_award_notice_id"]}"
        # If there's an ammended value, get that.
        if contract_data["amended_contract_value_est"] === nil
          v = contract_data["contract_value_est"]
        else
          v = contract_data["amended_contract_value_est"]
        end

        Contract.where(can_id: contract_data["contract_award_notice_id"]).first_or_initialize.update!(
          description: contract_data["particulars_of_the_goods_or_services_to_be_provided_under_this_contract"],
          url: contract_data["url"],
          start_date: Date.parse(contract_data["contract_start_date"]),
          end_date: Date.parse(contract_data["contract_end_date"]),
          value: v,
          contractor_id: Contractor.where(abn: contract_data["abn"]).first.id,
          date_scraped: Date.parse(contract_data["date_scraped"]),
          agency: contract_data["agency"],
          provisions_for_additional_services: contract_data["any_provisions_for_payment_to_the_contractor_for_operational_or_maintenance_services"],
          method_of_tendering: contract_data["method_of_tendering"],
          provisions_for_changing_value: contract_data["description_of_any_provision_under_which_the_amount_payable_to_the_contractor_may_be_varied"],
          provisions_for_renegotiation: contract_data["description_of_any_provisions_under_which_the_contract_may_be_renegotiated"],
          tender_evaluation_criteria: contract_data["tender_evaluation_criteria"],
          piggyback_clause: (contract_data["contract_contains_agency_piggyback_clause"] == "Yes" ? true : false),
          subcontractors: contract_data["name_of_sub_contractors"]
        )
      end
    end
  end

  desc "Update contractors then contracts from morph.io"
  task :update_all => [:get_contractors, :get_contracts]
end
