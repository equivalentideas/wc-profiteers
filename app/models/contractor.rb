class Contractor < ActiveRecord::Base
  has_paper_trail

  has_many :contracts, inverse_of: :contractor

  validates :name, :abn, presence: true
  validates :abn, uniqueness: true

  def total_est_contract_value
    contracts.sum(:value)
  end
end
