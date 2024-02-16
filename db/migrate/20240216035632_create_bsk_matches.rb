class CreateBskMatches < ActiveRecord::Migration[7.0]
  def change
    create_table :bsk_matches do |t|
      t.references :bsk_member, foreign_key: true
      t.integer :coat
      t.timestamps
    end
  end
end
