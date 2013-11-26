class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable, :confirmable,
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :sites

  #after_create :assign_reader_role

  #private
   #def assign_reader_role
    #self.add_role "user"
  #end
end
