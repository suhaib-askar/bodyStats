class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    can :read, :all     
    if user.role? :admin
      can :access, :rails_admin
      can :dashboard   
      can :manage, :all               
    elsif user.role? :support
      can :access, :rails_admin
      can :dashboard 
      can :manage, [User, Project] 
    end
  end
end
