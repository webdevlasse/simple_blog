class User < ActiveRecord::Base

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :role

  ROLES = [ 'admin' , 'default' ]

  def is?( requested_role )
    self.role == requested_role.to_s
  end

  def self.find_or_create_by_auth(auth_data)
     user = self.find_or_create_by_provider_and_uid(auth_data["provider"], auth_data["uid"])
     if user.name != auth_data["info"]["name"]
       user.name = auth_data["info"]["name"]
      user.save!
     end
     return user
   end

   def display_name
     self.name || self.email
   end

   protected
    def password_required?
      false
    end

    def email_required?
      false
    end

end
