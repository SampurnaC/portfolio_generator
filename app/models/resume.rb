class Resume < ApplicationRecord
  belongs_to :user
  has_many :projects, dependent: :destroy
  has_many :skills, dependent: :destroy

  accepts_nested_attributes_for :projects, allow_destroy: true
  accepts_nested_attributes_for :skills, allow_destroy: true
end
