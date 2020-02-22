# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  # callback for facebook
  def facebook
    callback_for(:facebook)
  end

  # callback for twitter
  def twitter
    callback_from :twitter
  end

  # callback for google
  def google_oauth2
    callback_for(:google)
  end

  # common callback method
  private
 
  def callback_from(provider)
    provider = provider.to_s
 
    @user = User.find_for_oauth(request.env['omniauth.auth'])
 
    if @user.persisted?
      flash[:notice] = I18n.t('devise.omniauth_callbacks.success', kind: provider.capitalize)
      sign_in_and_redirect @user, event: :authentication
      session[:user_id] = @user.id #追加されていたので追加
    else
      session["devise.#{provider}_data"] = request.env['omniauth.auth'].except("extra")
      redirect_to new_user_registration_url
    end
  end

  def failure
    redirect_to root_path
  end

  # You should configure your model like this:
  # devise :omniauthable, omniauth_providers: [:twitter]

  # You should also create an action method in this controller like this:
  # def twitter
  # end

  # More info at:
  # https://github.com/plataformatec/devise#omniauth

  # GET|POST /resource/auth/twitter
  # def passthru
  #   super
  # end

  # GET|POST /users/auth/twitter/callback
  # def failure
  #   super
  # end

  # protected

  # The path used when OmniAuth fails
  # def after_omniauth_failure_path_for(scope)
  #   super(scope)
  # end
end
