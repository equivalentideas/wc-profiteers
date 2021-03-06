require 'open-uri'

class Contract < ActiveRecord::Base
  has_paper_trail :ignore => [:date_scraped, :updated_at]

  belongs_to :contractor

  default_scope {order('start_date DESC')}

  def self.import_contracts_from_morph(with_debug_output: nil)
    morph_url_base = "https://api.morph.io/equivalentideas/westconnex_contracts/data.json?key=#{ENV['MORPH_SECRET_KEY']}&query="

    Contractor.all.each do |contractor|
      url = morph_url_base + "select%20contracts%20from%20'contractors'%20where%20abn%3D'#{contractor.abn}'"

      if with_debug_output
        puts "Getting contracts for #{contractor.name} with abn #{contractor.abn}"
        puts "from #{url}"
      end

      contracts_data = JSON.parse(open(url).read)
      if contracts_data.any?
        contracts_data[0]["contracts"].split(", ").each do |c|
          url = morph_url_base + "select%20*%20from%20'contracts'%20where%20contract_award_notice_id%3D'#{c}'"
          contract_data = JSON.parse(open(url).read)[0]

          if with_debug_output
            puts "updating #{contract_data["contract_award_notice_id"]}"
          end

          # If there's an amended value, get that.
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
      else
        if with_debug_output
          puts "no contracts for #{contractor.name}"
        end
      end
    end
  end

  # Note that this does not currently do de-duping for
  # existing contacts. This hasn't been necessary so far.
  # Remember, different contracts with the same can_id exists.
  def self.import_contracts_from_csv(csv_path)
    require 'csv'

    csv = CSV.parse(File.read(csv_path), headers: true)

    csv.each do |row|
      if Contractor.find_by(abn: row["abn"])
        contractor_id = Contractor.find_by(abn: row["abn"]).id
      else
        contractor_id = nil
      end

      contract = Contract.create(
        agency: row["agency"],
        can_id: row["can_id"],
        contractor_id: contractor_id,
        description: row["description"],
        start_date: row["start_date"],
        end_date: row["end_date"],
        value: row["value"],
        url: row["url"],
        method_of_tendering: row["method_of_tendering"]
      )
    end
  end

  def display_description
    description.sub(/^westconnex - /i, '').sub(/^WDA - /, '')
  end
end
