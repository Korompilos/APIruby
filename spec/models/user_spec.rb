require 'rails_helper'

RSpec.describe User, type: :model do
  # Έλεγχος σχέσης 1:m με τα Todos
  it { should have_many(:todos) }
  
  # Έλεγχος επικυρώσεων πεδίων
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password_digest) }
end