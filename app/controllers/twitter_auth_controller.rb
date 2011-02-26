#encoding: utf-8
class TwitterAuthController < ApplicationController
  def create
    load_admins
    user = request.env['rack.auth']['user_info']['nickname']
    if @users.include?(user)
      return successful_login(user)
    else
      flash[:notice] = "Você não está autorizado a acessar esta área."
      redirect_to('/')
    end
  end


  protected

  def successful_login(user)
    session[:logged_in] = true
    session[:nickname] = user.to_s
    redirect_to(admin_root_path)
  end
  
  def load_admins
    @users = ["alobato",
      "fernandokosh",
      "lucianosousa",
      "raph_almeida",
      "yuizinha",
      "tauil"
    ]
  end
end
