class CreateExperiences < ActiveRecord::Migration[8.0]
  def change
    create_table :experiences do |t|
      t.string :position
      t.string :company_name
      t.string :summary
      t.date :date_from
      t.date :date_to
      t.boolean :currently_working
      t.references :resume, null: false, foreign_key: true

      t.timestamps
    end
  end
end
