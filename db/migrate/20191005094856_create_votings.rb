class CreateVotings < ActiveRecord::Migration[5.2]
  def change
    create_table :votings do |t|
      t.string :name
      t.text :description
      t.decimal :number_of_votes

      t.timestamps
    end
  end
end
