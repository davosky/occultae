class Group < ApplicationRecord
  has_and_belongs_to_many :users

  validates :name, presence: true
  validates :name, uniqueness: true

  def self.ransackable_attributes(auth_object = nil)
    [ "name", "users" ]
  end
end
