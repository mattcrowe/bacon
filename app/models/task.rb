class Task < ActiveRecord::Base
  belongs_to :project
  has_many :entries
  def to_s
    name
  end
end
