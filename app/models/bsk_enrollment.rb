class BskEnrollment < ApplicationRecord
    belongs_to :bsk_member
    belongs_to :bsk_match
end
