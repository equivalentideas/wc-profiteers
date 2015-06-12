class Contract < ActiveRecord::Base
  has_paper_trail :ignore => [:date_scraped, :updated_at]

  belongs_to :contractor

  validates :can_id, uniqueness: true

  default_scope {order('start_date DESC')}

  def display_description
    if description[0..12] == 'WestConnex - '
      description.sub('WestConnex - ', '')
    elsif description[0..5] == 'WDA - '
      description.sub('WDA - ', '')
    else
      description
    end
  end
end
