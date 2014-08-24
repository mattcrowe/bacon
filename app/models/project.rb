class Project < ActiveRecord::Base
  belongs_to :client
  has_many :tasks, dependent: :destroy

  default_scope {order(:name)}

  def to_s
    name
  end
end
