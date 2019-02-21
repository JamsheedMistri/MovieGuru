class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.integer :movie
      t.string :date
      t.string :email
      t.integer :rating
      t.text :comment

      t.timestamps
    end
  end
end
