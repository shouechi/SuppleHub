class ApplicationController < ActionController::Base
  # 新規登録でのパラメーター設定
  before_action :configure_permitted_parameters, if: :devise_controller?
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :name, :email, :password, :password_confirmation ])
    devise_parameter_sanitizer.permit(:sign_in, keys: [ :email, :password ])
  end

  # ログイン後投稿一覧へ遷移
  def after_sign_in_path_for(resource)
    posts_path
  end
end
