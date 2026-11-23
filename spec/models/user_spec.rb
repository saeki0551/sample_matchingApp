require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'ユーザー作成' do
    context 'ユーザーが作成される場合'
    it 'ユーザーが問題なく作成できる' do
      user = FactoryBot.create(:user)
      expect(user).to be_valid
      expect(user.errors).to be_empty
    end

    context 'メールアドレスが空の場合'
    it 'ユーザーが作成されない' do
      begin
        user = FactoryBot.create(:user, email: nil)
      rescue
        expect(user).to be_blank
      end
    end
  end
end
