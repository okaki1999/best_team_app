class BskMember < ApplicationRecord
    has_many :bsk_participations, dependent: :destroy
    has_many :bsk_enrollments, dependent: :destroy
    belongs_to :bsk_match, optional: true
    attribute :total_match, :integer, default: 0
    
    def point_per_game
      return 0 if total_match == 0  # ゼロ除算を防ぐために、total_match が 0 の場合は 0 を返す
  
      scoring_rate.to_f / total_match
    end
  
    def bsk_already_participation?
      bsk_participations.exists?(bsk_member_id: id)
    end
    validates :name, presence: true
end
