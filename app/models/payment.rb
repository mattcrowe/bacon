class Payment < ActiveRecord::Base
  belongs_to :client

  def to_s
    'Payment#' + id.to_s
  end
end
