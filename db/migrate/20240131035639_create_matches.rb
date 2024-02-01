class CreateMatches < ActiveRecord::Migration[7.0]
  def change
    create_table :matches do |t|
      t.references :member, foreign_key: true
      t.integer :coat

      t.timestamps
    end
  end
end
