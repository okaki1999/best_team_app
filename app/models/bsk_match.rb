class BskMatch < ApplicationRecord
    has_many :bsk_enrollments, dependent: :destroy
    has_many :bsk_members, through: :bsk_enrollments

    accepts_nested_attributes_for :bsk_members 
end
