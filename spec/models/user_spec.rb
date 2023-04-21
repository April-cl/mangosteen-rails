require 'rails_helper'

RSpec.describe User, type: :model do
  
  it '有 email' do
    user = User.new email: 'april@xxx.com'
    expect(user.email).to eq 'april@xxx.com'
  end
end
