class UsersController < ApplicationController
  def show
    user = User.find_by_id params[:id]
    if user
      render json: user
    else
      head 404
    end
  end

  def create
    user = User.new name: 'April'
    if user.save
      p 'save 成功'
      render json: user
    else
      p 'save 失败'
      render json: user.errors
    end
  end
end
