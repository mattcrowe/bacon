class Invoice < ActiveRecord::Base
  belongs_to :client
  has_many :entries

  def to_s
    'Invoice#' + id.to_s
  end

end
