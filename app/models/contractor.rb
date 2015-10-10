class Contractor < ActiveRecord::Base
  has_paper_trail

  has_many :contracts, inverse_of: :contractor

  validates :name, :abn, presence: true
  validates :abn, uniqueness: true

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
    if acn.present?
      acn
    else
      abn
    end
  end
end
