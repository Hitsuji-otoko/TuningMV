class HomeController < ApplicationController
  def index
  end

  def test
  end

  # ゲストユーザーでログインする
  def new_guest
    user = User.find_or_create_by!(username: 'ゲストユーザー') do |user|
      user.password = SecureRandom.urlsafe_base64
      
    end
    sign_in user
    redirect_to root_path, notice: 'ゲストユーザーとしてログインしました。'
  end
end
