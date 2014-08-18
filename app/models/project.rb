class Project < ActiveRecord::Base
  belongs_to :client
  has_many :tasks, dependent: :destroy
end
