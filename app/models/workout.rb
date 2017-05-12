class Workout < ActiveRecord::Base
    belongs_to :user

    validates_presence_of :activity_description, :date, :duration
end