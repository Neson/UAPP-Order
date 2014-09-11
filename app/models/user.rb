class User < ActiveRecord::Base
  include RailsSettings::Extend
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :rememberable, :trackable, :validatable
  devise :omniauthable, :omniauth_providers => [:uapp]
  devise :timeoutable, :timeout_in => 30.minutes

  has_many :orders

  def avatar(size=100)
    'https://graph.facebook.com/' + fbid.to_s + '/picture?width=' + size.to_s + '&height=' + size.to_s
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

    auth.info['settings'].each do |k, v|
      user.settings[k] = v
    end

    user.fbid = auth.info.fbid
    user.email = auth.info.email
    user.name = auth.info.name
    user.gender = auth.info.gender
    user.mobile_verified = auth.info.mobile_verified
    user.identity = auth.info.identity
    user.student_id = auth.info.student_id
    user.admission_department_code = auth.info.admission_department_code
    user.department_code = auth.info.department_code
    user.admission_department = auth.info.admission_department
    user.department = auth.info.department

    user.data_update_time = Time.now
    return user
  end

  def self.from_rfid(code, return_raw_data=false)
    get_data_connection = HTTParty.get("#{Setting.uapp_url}/api/v1/rfid_scan/#{code}.json?application_id=#{Setting.uapp_app_id}&secret=#{Setting.uapp_app_secret}")
    if get_data_connection.code == 200
      user_uid = get_data_connection.parsed_response['uid']
      user = where({:uid => user_uid}).first
      if !!user
        return user
      else
        if return_raw_data
          return get_data_connection.parsed_response
        else
          return nil
        end
      end
    else
      return nil
    end
  end
end
