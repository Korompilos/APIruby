class Todo < ApplicationRecord
  # Σχέσεις
  has_many :items, dependent: :destroy
  # Σύνδεση με τον User μέσω του created_by
  belongs_to :user, foreign_key: :created_by

  # Επικυρώσεις
  validates_presence_of :title, :created_by
end