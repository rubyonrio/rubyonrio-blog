#encoding: utf-8
class TwitterAuthController < ApplicationController
  def create
    load_admins
    user = request.env['omniauth.auth']['user_info']['nickname']
    if @users.include?(user)
      flash[:notice] = "Logado com sucesso."
      successful_login(user)
    else
      flash[:notice] = "Você não está autorizado a acessar esta área."
      redirect_to('/')
    end
  end

  def destroy
    session[:logged_in] = false
    redirect_to root_url, :notice => "Deslogado com sucesso."
  end

  protected

  def successful_login(user)
    session[:logged_in] = true
    session[:nickname] = user.to_s
    redirect_to(admin_root_path)
  end

  def load_admins
    @users = Enki::Config.default[:author, :admins]
    Member.where(:admin => true).each do |member|
      username = member.twitter_username
      @users << username unless @users.include?(username)
    end
  end
end
