class AddMatchToMembers < ActiveRecord::Migration[7.0]
  def change
    add_reference :members, :match, foreign_key: true
  end
end
