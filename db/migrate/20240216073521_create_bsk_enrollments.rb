class CreateBskEnrollments < ActiveRecord::Migration[7.0]
  def change
    create_table :bsk_enrollments do |t|
      t.references :bsk_member, foreign_key: true
      t.references :bsk_match, foreign_key: true

      t.timestamps
    end
  end
end
