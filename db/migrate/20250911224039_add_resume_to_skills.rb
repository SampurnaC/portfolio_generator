class AddResumeToSkills < ActiveRecord::Migration[8.0]
  def change
    add_reference :skills, :resume, null: false, foreign_key: true
  end
end
