class RenamePortfoliosToResumes < ActiveRecord::Migration[8.0]
  def change
    rename_table :portfolios, :resumes
  end
end
