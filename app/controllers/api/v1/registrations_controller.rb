# frozen string literal: true

class Api::V1::RegistrationsController < Devise::RegistrationsController
  before_action :ensure_params, only: :create

  # sign up
  def create
    user = User.new(user_params)
    if user.save
      json_response('Signed Up Successfully', true, { user: user }, :ok)
    else
      json_response('Something Wrong', false, {}, :unprocessable_entity) # 442 status_code
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

  def ensure_params
    return if params[:user].present?

    json_response('Missing Params', false, {}, :bad_request)
  end
end