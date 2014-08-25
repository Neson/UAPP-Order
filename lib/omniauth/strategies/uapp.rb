require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Uapp < OmniAuth::Strategies::OAuth2
      include OmniAuth::Strategy
      # change the class name and the :name option to match your application name
      # option :name, :doorkeeper

      option :client_options, {
        :site => Setting.uapp_url,
        :authorize_url => "/oauth/authorize"
      }

      uid { raw_info["id"] }

      info do
        {
          :id => raw_info["id"],
          :uid => raw_info["uid"],
          :name => raw_info["name"],
          :gender => raw_info["gender"],
          :mobile_verified => raw_info["mobile_verified"],
          # and anything else you want to return to your API consumers
          :email => raw_info["email"],
          :student_id => raw_info["student_id"],
          :identity => raw_info["identity"],
          :admission_department_code => raw_info["admission_department_code"],
          :department_code => raw_info["department_code"],
          :college => raw_info["college"],
          :admission_department => raw_info["admission_department"],
          :department => raw_info["department"],
          :fbid => raw_info["fbid"],
          :fbtoken => raw_info["fbtoken"]
        }
      end

      def raw_info
        @raw_info ||= access_token.get('/api/v1/me.json').parsed
      end
    end
  end
end
