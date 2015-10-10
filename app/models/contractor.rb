class Contractor < ActiveRecord::Base
  has_paper_trail

  has_many :contracts, inverse_of: :contractor

  validates :name, :abn, presence: true
  validates :abn, uniqueness: true

  def self.import_contractors_from_morph
    require 'open-uri'

    url = "https://api.morph.io/equivalentideas/westconnex_contracts/data.json?key=#{ENV['MORPH_SECRET_KEY']}&query=select%20*%20from%20'contractors'"
    contractors = JSON.parse(open(url).read)

    contractors.each do |c|
      Contractor.where(abn: c["abn"]).first_or_initialize.update!(
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
  end

  def self.import_contractors_from_csv(csv_path)
    require 'CSV'
    csv = CSV.parse(File.read(csv_path), headers: true)

    csv.each do |row|
      if Contractor.find_by(abn: row["abn"]).nil?
        Contractor.create(
          name: row['name'],
          abn: row['abn'],
          acn: row['acn']
        )
      end
    end
  end

  def total_est_contract_value
    contracts.sum(:value)
  end

  def corporate_id
    acn.present? ? acn : abn
  end
end
