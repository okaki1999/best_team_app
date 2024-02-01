class CreateEnrollments < ActiveRecord::Migration[7.0]
  def change
    create_table :enrollments do |t|
      t.references :member, foreign_key: true
      t.references :match, foreign_key: true

      t.timestamps
    end
  end
end
