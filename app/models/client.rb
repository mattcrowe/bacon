class Client < ActiveRecord::Base
    has_many :projects, dependent: :destroy
    validates :name, presence: true,
                        length: { minimum: 5 }

end
