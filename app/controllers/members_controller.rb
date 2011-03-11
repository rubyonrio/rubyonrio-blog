class MembersController < ApplicationController
  def index
    @members = Member.all

    respond_to do |format|
      format.html
      format.xml  { render :xml => @members }
    end
  end

  def show
    @member = Member.find_by_username(params[:username])

    respond_to do |format|
      format.html
      format.xml  { render :xml => @member }
    end
  end
end
