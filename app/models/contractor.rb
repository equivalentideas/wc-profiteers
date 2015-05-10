class Contractor < ActiveRecord::Base
  has_many :contracts, inverse_of: :contractor

  validates :name, :abn, presence: true
  validates :abn, uniqueness: true
end
