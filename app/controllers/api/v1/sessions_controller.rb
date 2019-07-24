# frozen string literal: true

class Api::V1::SessionsController < Devise::SessionsController
  before_action :sign_in_params, only: :create
  before_action :load_user, only: :create

  # sign in
  def create
    if @user.valid_password?(sign_in_params[:password])
      sign_in :user, @user
      json_response('Signed in Successfully', true, { user: @user }, :ok)
    else
      json_response('Unauthorized', false, {}, :unauthorized)
    end
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
end