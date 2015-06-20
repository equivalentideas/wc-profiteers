class Contract < ActiveRecord::Base
  has_paper_trail :ignore => [:date_scraped, :updated_at]

  belongs_to :contractor

  validates :can_id, uniqueness: true

  default_scope {order('start_date DESC')}

  def display_description
    description.gsub(/^westconnex - /i, '').sub(/^WDA - /, '')
  end
end
