class AddTotalMatch2ToBskMembers < ActiveRecord::Migration[7.0]
  def change
    add_column :bsk_members, :point_per_game, :integer
  end
end
