# frozen_string_literal: true

class Ability
  include CanCan::Ability
  def initialize(user)
    arr = []
    user.write_privileges.each do |e|
        arr << Object.const_get(e)
    end
    arr1 = []
    user.create_privileges.each do |e|
        arr1 << Object.const_get(e)
    end
    puts arr1
    arr2 = []
    user.delete_privileges.each do |e|
        arr2 << Object.const_get(e)
    end
    puts arr2
    arr4 = []
     user.read_privileges.each do |e|
        arr4 << Object.const_get(e)
    end
    can :access, :rails_admin       
    can :manage, :dashboard
    if user.role.to_s == "super_admin"
        puts "i am in super_admin"
         can :read, :all
         can :update, Admin
         can :active_action, User
    elsif user.role.to_s == "admin"
        can :read, arr4
        can :read, Version
        can :create, Version
         can :update, arr
         can :create, arr1
         can :destroy, arr2
        can :active_action, User
    elsif user.role.to_s == "executive"
        can :read, arr4
         can :update, arr
         can :create, arr1
         can :destroy, arr2
    end
   end
end
