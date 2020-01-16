require 'rails_helper'

RSpec.describe User, type: :model do
  describe "ユーザーのvalidationのテスト" do
    before do
      @user = build(:user)
    end
    
    it 'ユーザー名、メールアドレス、パスワードがあれば有効' do
      expect(@user.valid?).to eq(true)
    end
    
    it 'ユーザー名が空欄ならば無効' do
      @user.username = nil
      expect(@user.valid?).to eq(false)
    end
  end
end

