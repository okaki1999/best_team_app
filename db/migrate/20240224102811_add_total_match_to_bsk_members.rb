class AddTotalMatchToBskMembers < ActiveRecord::Migration[7.0]
  def change
    add_column :bsk_members, :total_match, :integer
  end
end
