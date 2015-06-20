class Contract < ActiveRecord::Base
  has_paper_trail :ignore => [:date_scraped, :updated_at]

  belongs_to :contractor

  validates :can_id, uniqueness: true

  default_scope {order('start_date DESC')}

  def display_description
    if description =~ /^westconnex - /i
      description.gsub(/^westconnex - /i, '')
    elsif description =~ /^WDA - /
      description.sub(/^WDA - /, '')
    else
      description
    end
  end
end
