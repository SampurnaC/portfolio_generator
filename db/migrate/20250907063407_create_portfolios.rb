class CreatePortfolios < ActiveRecord::Migration[8.0]
  def change
    create_table :portfolios do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.string :slug
      t.string :bio
      t.string :theme

      t.timestamps
    end
  end
end
