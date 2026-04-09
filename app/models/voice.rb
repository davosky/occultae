class Voice < ApplicationRecord
  belongs_to :feature
  has_and_belongs_to_many :groups, -> { order(:name) }
  has_and_belongs_to_many :users, -> { order(:last_name) }

  attr_accessor :group_ids_csv

  before_validation :assign_groups_from_csv

  def group_ids=(value)
    if value.is_a?(String)
      @group_ids_csv = value
    else
      super
    end
  end

  enum :value_type,   { bottone: 0, gruppo: 1 }
  enum :value_option, { si: 0, no: 1, gr: 2 }

  def self.ransackable_attributes(auth_object = nil)
    [ "name", "grouping", "value_option", "value_type" ]
  end

  private

  def assign_groups_from_csv
    return unless @group_ids_csv.present?

    self.group_ids = @group_ids_csv.split(",")
  end
end
