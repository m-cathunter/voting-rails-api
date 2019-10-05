class CreateVotes < ActiveRecord::Migration[5.2]
  def change
    create_table :votes do |t|
      t.references :voting, foreign_key: true
      t.string :name
      t.decimal :number

      t.timestamps
    end
  end
end
