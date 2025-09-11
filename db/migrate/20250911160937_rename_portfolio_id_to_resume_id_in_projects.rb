class RenamePortfolioIdToResumeIdInProjects < ActiveRecord::Migration[8.0]
  def change
    rename_column :projects, :portfolio_id, :resume_id
  end
end
