# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create
    user = User.find_by(email: params[:user][:email])
    # メールアドレスがない場合の処理
    if user.nil?
      flash[:alert] = "そのメールアドレスは登録されていません。新規登録してください。"
      redirect_to new_user_registration_path
    else
      # パスワード、deleted_atにデータ入ってないか確認しdeleted_atに日付が入っていれば再度ログイン画面へ遷移させる
      if user.valid_password?(params[:user][:password]) && user.deleted_at.nil?
        flash[:notice] = "ログインに成功しました"
        sign_in user
        redirect_to posts_path
      else
        flash[:alert] = "メールアドレスまたはパスワードが間違っています。"
        redirect_to new_user_session_path
      end
    end
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
