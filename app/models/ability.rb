# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    # ==================================================================
    # Boss
    # Boss can do everything
    can :manage, :all if supervisor.boss == true
  end
end
