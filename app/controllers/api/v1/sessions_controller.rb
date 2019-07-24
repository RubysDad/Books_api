# frozen string literal: true

class Api::V1::SessionsController < Devise::SessionsController
  before_action :sign_in_params, only: :create
  before_action :load_user, only: :create
  before_action :valid_token, only: :destroy
  skip_before_action :verify_signed_out_user, only: :destroy

  # sign in
  def create
    if @user.valid_password?(sign_in_params[:password])
      sign_in :user, @user
      json_response('Signed in Successfully', true, { user: @user }, :ok)
    else
      json_response('Unauthorized', false, {}, :unauthorized)
    end
  end

  # log out
  def destroy
    sign_out @user
    @user.generate_new_authentication_token
    json_response('Log out Successfully', true, {}, :ok)
  end

  private

  def sign_in_params
    params.require(:sign_in).permit(:email, :password)
  end

  def load_user
    @user = User.find_for_database_authentication(email: sign_in_params[:email])

    return @user if @user.present?

    json_response("Cannot find User", false, {}, :failure)
  end

  def valid_token
    @user = User.find_by(authentication_token: request.headers["AUTH-TOKEN"])

    return @user if @user.present?

    json_response('Invalid Token', false, {}, :failure)
  end
end