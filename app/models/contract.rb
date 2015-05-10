class Contract < ActiveRecord::Base
  belongs_to :contractor

  validates :can_id, uniqueness: true
end
