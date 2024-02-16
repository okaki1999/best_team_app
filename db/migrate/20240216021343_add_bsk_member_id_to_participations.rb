class AddBskMemberIdToParticipations < ActiveRecord::Migration[7.0]
  def change
    add_column :participations, :bsk_member_id, :integer
  end
end
