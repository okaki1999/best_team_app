class BskMember < ApplicationRecord
    has_many :bsk_participations, dependent: :destroy
    has_many :bsk_enrollments, dependent: :destroy
    belongs_to :bsk_match, optional: true
  
    def bsk_already_participation?
      bsk_participations.exists?(bsk_member_id: id)
    end
    validates :name, presence: true
end
