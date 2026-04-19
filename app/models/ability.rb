# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user.present?

    # ==================================================================
    # Boss: full access
    if user.boss?
      can :manage, :all

    # Manager: read/write everything, cannot destroy
    elsif user.manager?
      can [ :read, :create, :update ], :all

    # Regular: read-only
    elsif user.regular?
      can :read, :all
    end
  end
end
