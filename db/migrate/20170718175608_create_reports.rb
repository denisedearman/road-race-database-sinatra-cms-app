class CreateReports < ActiveRecord::Migration[5.1]
  def change
    create_table :reports do |t|
      t.string :title
      t.integer :score
      t.integer :year
      t.string :content
      t.integer :runs_per_week
      t.integer :miles_per_week
      t.integer :user_id
      t.integer :race_id
    end
  end
end
