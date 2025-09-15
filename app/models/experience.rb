class Experience < ApplicationRecord
  belongs_to :resume
  validates :position, :company_name, :summary, :date_from, presence: true
  validates :date_to, presence: true, unless: :currently_working
end
