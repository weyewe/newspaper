class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # in case of guest
    if user.has_role? :admin
      can :manage, :all
    elsif user.has_role? :writer
      can :manage, Story 
    else
      can :read, Story
    end
  end
end
