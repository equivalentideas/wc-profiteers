class Contractor < ActiveRecord::Base
  has_many :contracts, inverse_of: :contractor
end
