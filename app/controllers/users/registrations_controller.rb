# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  def new
    super
  end

  # POST /resource
  # def create
  #   super
  # end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  def destroy
    # 論理削除処理
    soft_delete(current_user)
    respond_with_navigational do
      sign_out current_user
      flash[:notice] = "アカウントを削除しました"
      redirect_to root_path
    end
  end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # パスワードなしで更新できるメソッド
  def update_resource(resource, params)
    resource.update_without_password(params)
  end

  def after_update_path_for(resource)
    flash[:notice] = "ユーザー情報を更新しました"
    user_path(resource)
  end


  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end

  private

  def soft_delete(user)
    # 同じメールアドレスでも登録できるように、 メールアドレスを“******_deleted_**********”に変更する
    deleted_email = user.email + "_deleted_" + Time.current.to_i.to_s
    user.assign_attributes(email: deleted_email, deleted_at: Time.current)
    # 　通知メールをキャンセルする
    user.skip_email_changed_notification!
    user.save
  end
end
