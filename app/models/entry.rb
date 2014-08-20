class Entry < ActiveRecord::Base
  belongs_to :task
  belongs_to :invoice
end
