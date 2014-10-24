class Entry < ActiveRecord::Base
  belongs_to :task
  belongs_to :invoice

  # scope :desc, order("entries.done_at DESC")

  def to_s
    'Entry#' + id.to_s
  end
end
