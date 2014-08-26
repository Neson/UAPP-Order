class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :rememberable, :trackable, :validatable
  devise :omniauthable, :omniauth_providers => [:uapp]
  devise :timeoutable, :timeout_in => 30.minutes

  def avator(size=100)
    # 'https://graph.facebook.com/' + fbid.to_s + '/picture?width=' + size.to_s + '&height=' + size.to_s
  end

  # def admission_college_name
  #   admission_department && admission_department.college && admission_department.college.name
  # end

  # def admission_department_name
  #   admission_department && admission_department.name
  # end

  # def college_name
  #   department && department.college && department.college.name
  # end

  # def department_name
  #   department && department.name
  # end

  def self.from_uapp(auth)
    user = where({:uid => auth.uid}).first_or_create! do |user|
      user.email = "#{auth.uid}@uapp.app"
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name
    end
    return user
  end
end
