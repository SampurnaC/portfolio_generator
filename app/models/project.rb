class Project < ApplicationRecord
  belongs_to :resume
  validates :title, presence: true
end
