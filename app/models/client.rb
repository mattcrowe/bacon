class Client < ActiveRecord::Base
    has_many :projects, dependent: :destroy
    has_many :invoices, dependent: :destroy

    validates :name, presence: true, length: { minimum: 5 }

    def to_s
      name
    end
end