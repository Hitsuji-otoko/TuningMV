require 'rails_helper'

RSpec.describe User, type: :model do
  it "ユーザー名、メール、パスワードがあれば有効" do
  # TODO: FactoryBotでテストユーザーを作成する
    user = User.new(
      username: "testuser",
      email: "testuser@testuser.com",
      password: "password"
    )
    expect(user).to be_valid
  end

  # パスしない
  it "ユーザー名がなければ無効" do
    user = User.new(username: nil)

    user.valid?
    expect(user.errors[:username]).to include("入力されていません")
  end
end

