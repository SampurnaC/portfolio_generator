class AddPaidToResumes < ActiveRecord::Migration[8.0]
  def change
    add_column :resumes, :paid, :boolean, default: false
  end
end
