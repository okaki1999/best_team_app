class Enrollment < ApplicationRecord
    belongs_to :member
    belongs_to :match
end
