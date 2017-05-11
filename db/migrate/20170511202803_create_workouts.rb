class CreateWorkouts < ActiveRecord::Migration[5.1]
  def change
    create_table :workouts do |t|
      t.string :activity_description
      t.string :duration
      t.string :date
      t.integer :user_id
    end
  end
end
