class AddParticipantToParticipations < ActiveRecord::Migration[7.0]
  def change
    add_reference :participations, :participant, polymorphic: true, index: true
  end
end
