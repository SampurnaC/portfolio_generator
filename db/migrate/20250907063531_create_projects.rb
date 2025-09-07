class CreateProjects < ActiveRecord::Migration[8.0]
  def change
    create_table :projects do |t|
      t.references :portfolio, null: false, foreign_key: true
      t.string :title
      t.string :summary
      t.string :url

      t.timestamps
    end
  end
end
