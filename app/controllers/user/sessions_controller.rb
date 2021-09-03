# frozen_string_literal: true

class User::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create
    super
     @user = User.find(current_user.id)
    @user.status = 1
    @user.save
  end

  # DELETE /resource/sign_out
  def destroy
    @user = User.find(current_user.id)
    @user.status = 0
    @user.save
    super
  end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
