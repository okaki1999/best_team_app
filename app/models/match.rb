class Match < ApplicationRecord
    has_many :enrollments, dependent: :destroy
    has_many :members, through: :enrollments

    accepts_nested_attributes_for :members  
end
