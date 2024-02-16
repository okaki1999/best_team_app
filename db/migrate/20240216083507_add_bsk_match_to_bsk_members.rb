class AddBskMatchToBskMembers < ActiveRecord::Migration[7.0]
  def change
    add_reference :bsk_members, :bsk_match, foreign_key: true
  end
end
