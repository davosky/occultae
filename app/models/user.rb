class User < ApplicationRecord
  validates :username, :first_name, :last_name, :gender, :region, :province, :category, presence: true
  validates :username, uniqueness: true

  def self.ransackable_attributes(auth_object = nil)
    [ "username", "first_name", "last_name", "category", "region", "province", "institute", "office", "groups" ]
  end
end
