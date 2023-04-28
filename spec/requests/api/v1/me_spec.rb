require 'rails_helper'

RSpec.describe "Me", type: :request do
  describe "会获取当前用户话" do
    it "登录成功后获取" do
      user = User.create email: 'xcl8202@qq.com'
      post '/api/v1/session', params: {email: 'xcl8202@qq.com', code: '123456'}
      json = JSON.parse response.body
      jwt = json['jwt']

      get '/api/v1/me', headers: {'Authorization': "Bearer #{jwt}"}
      expect(response).to have_http_status(200)
      json = JSON.parse response.body
      expect(json['resource']['id']).to eq user.id
    end
  end
end