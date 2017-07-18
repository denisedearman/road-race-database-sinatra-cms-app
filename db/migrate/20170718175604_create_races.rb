class CreateRaces < ActiveRecord::Migration[5.1]
  def change
    create_table :races do |t|
      t.string :name
      t.string :location
      t.string :next_race_day
      t.string :distance
    end
  end
end
