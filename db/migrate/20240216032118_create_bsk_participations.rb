class CreateBskParticipations < ActiveRecord::Migration[7.0]
  def change
    create_table :bsk_participations do |t|
      t.integer :bsk_member_id
      t.timestamps
    end
  end
end
