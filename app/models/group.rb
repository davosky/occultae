class Group < ApplicationRecord
  validates :name, presence: true
  validates :name, uniqueness: true

  def self.ransackable_attributes(auth_object = nil)
    [ "name", "users" ]
  end
end
