class AddForeignKeyConstraintsToParticipations < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :participations, :members, on_delete: :nullify
  end
end
