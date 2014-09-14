class Staff < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :lockable, :rememberable, :trackable, :validatable

  has_many :actions, class_name: "OrderState"
end
