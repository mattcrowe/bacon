class Project < ActiveRecord::Base
  belongs_to :client
  has_many :tasks, dependent: :destroy

  def to_s
    name
  end
end
