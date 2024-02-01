class RemoveParticipationsForeignKey < ActiveRecord::Migration[7.0]
  def up
    remove_foreign_key "enrollments", "matches"
    remove_foreign_key "enrollments", "members"
    remove_foreign_key "matches", "members"
    remove_foreign_key "members", "matches"
    remove_foreign_key "participations", "members"
  end

  def down
    add_foreign_key "enrollments", "matches"
    add_foreign_key "enrollments", "members"
    add_foreign_key "matches", "members"
    add_foreign_key "members", "matches"
    add_foreign_key "participations", "members"
  end
end
