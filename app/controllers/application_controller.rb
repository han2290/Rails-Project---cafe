class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method(:user_signed_in?)
  
  
  #현재 로그인 된 상태니?
  def user_signed_in?
      session[:name].present?
  end
  
  def authenticate_user!#!:bang 원하지 않은 액션이 일어날 수 있는 경우 !가 붙는다.
      redirect_to '/sign_in' unless user_signed_in?
  end
  
  #현재 로그인 된 사람이 누구니?
  def current_user
      #현재 로그인이 됨?
      if user_signed_in?
        #로그인이 되었다면, 누가했니?
        @current_user = User.find(session[:name])
      end
  end
end

  #