require 'rails_helper'
require "active_support/testing/time_helpers"

RSpec.describe "Me", type: :request do
include ActiveSupport::Testing::TimeHelpers
  describe "会获取当前用户话" do
    it "登录成功后获取" do
      user = User.create email: 'xcl8202@qq.com'
      post '/api/v1/session', params: {email: 'xcl8202@qq.com', code: '123456'}
      expect(response).to have_http_status(200)
      json = JSON.parse response.body
      jwt = json['jwt']

      get '/api/v1/me', headers: {'Authorization': "Bearer #{jwt}"}
      expect(response).to have_http_status(200)
      json = JSON.parse response.body
      expect(json['resource']['id']).to eq user.id
    end
     it "jwt过期" do
      travel_to Time.now - 3.hours
      user1 = User.create email: '1@qq.com'
      jwt = user1.generate_jwt

      travel_back
      get '/api/v1/me', headers: {'Authorization': "Bearer #{jwt}"}
      expect(response).to have_http_status(401)
    end
    it "jwt没过期" do
      travel_to Time.now - 1.hours
      user1 = User.create email: '1@qq.com'
      jwt = user1.generate_jwt

      travel_back
      get '/api/v1/me', headers: {'Authorization': "Bearer #{jwt}"}
      expect(response).to have_http_status(200)
    end
  end
end