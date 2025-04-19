require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build(:user) }

  describe 'ユーザー作成バリデーション' do
    context '成功した場合' do
      it 'ユーザーが正常に作成されること' do
        expect(user).to be_valid
      end
    end

    context '失敗した場合' do
      it '名前が空の場合、無効であること' do
        user.name = nil
        expect(user).not_to be_valid
        expect(user.errors.full_messages).to include('Nameを入力してください')
      end

      it 'メールアドレスが空の場合、無効であること' do
        user.email = nil
        expect(user).not_to be_valid
        expect(user.errors.full_messages).to include('Eメールを入力してください')
      end

      it 'メールアドレスが重複している場合、無効であること' do
        create(:user, email: user.email)
        expect(user).not_to be_valid
        expect(user.errors.full_messages).to include('Eメールはすでに存在します')
      end

      it 'メールアドレスが不正な形式の場合、無効であること' do
        user.email = 'invalid_email'
        expect(user).not_to be_valid
        expect(user.errors.full_messages).to include('Eメールは不正な値です')
      end

      it 'パスワードが空の場合、無効であること' do
        user.password = nil
        expect(user).not_to be_valid
        expect(user.errors.full_messages).to include('パスワードを入力してください')
      end

      it 'パスワードと確認用パスワードが一致しない場合、無効であること' do
        user.password_confirmation = 'different_password'
        expect(user).not_to be_valid
        expect(user.errors.full_messages).to include('パスワード（確認用）とパスワードの入力が一致しません')
      end

      it 'パスワードが6文字未満の場合、無効であること' do
        user.password = 'short'
        user.password_confirmation = 'short'
        expect(user).not_to be_valid
        expect(user.errors.full_messages).to include('パスワードは6文字以上で入力してください')
      end
    end
  end
end
