class CreateBskMembers < ActiveRecord::Migration[7.0]
  def change
    create_table :bsk_members do |t|
      t.string :name
      t.integer :scoring_rate

      t.timestamps
    end
  end
end
