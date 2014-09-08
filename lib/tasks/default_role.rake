# encoding: UTF-8
namespace :db do
  desc "Set defaut user role"
  task set_default_role: :environment do
    default_role
  end
end

def default_role
  User.all.each do |u|
    u.update_attribute(:role_id, Role.find_by(name: "registered").id)
  end
end