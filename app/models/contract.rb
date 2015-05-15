class Contract < ActiveRecord::Base
  belongs_to :contractor

  validates :can_id, uniqueness: true

  default_scope {order('start_date DESC')}
end
