class Member < ApplicationRecord
    has_many :participations, dependent: :destroy
    has_many :enrollments, dependent: :destroy
    belongs_to :match, optional: true
  
    def already_participation?
      participations.exists?(member_id: id)
    end
    validates :name, presence: true
end
