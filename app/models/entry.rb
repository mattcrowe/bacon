class Entry < ActiveRecord::Base
  belongs_to :task
  belongs_to :invoice

  def to_s
    'Entry#' + id.to_s
  end
end
