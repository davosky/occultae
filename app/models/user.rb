class User < ApplicationRecord
  has_secure_password

  has_and_belongs_to_many :groups
  has_and_belongs_to_many :nodes
  has_and_belongs_to_many :voices

  validates :username, :first_name, :last_name, :gender, :region, :province, :category, presence: true
  validates :username, uniqueness: true
  validates :password, length: { minimum: 8 }, allow_nil: true

  def self.ransackable_attributes(auth_object = nil)
    [ "username", "first_name", "last_name", "category", "region", "province", "institute", "office" ]
  end

  def self.ransackable_associations(auth_object = nil)
    []
  end
end
