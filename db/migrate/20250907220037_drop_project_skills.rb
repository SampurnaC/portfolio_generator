class DropProjectSkills < ActiveRecord::Migration[8.0]
  def change
    drop_table :project_skills
  end
end
