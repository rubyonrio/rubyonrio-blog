class Admin::MembersController < Admin::BaseController

  def index
    @members = Member.all

    respond_to do |format|
      format.html
    end
  end

  def show
    @member = Member.find(params[:id])

    respond_to do |format|
      format.html
    end
  end

  def new
    @member = Member.new

    respond_to do |format|
      format.html
    end
  end

  def edit
    @member = Member.find(params[:id])
    respond_to do |format|
      format.html
    end

  end

  def create
    @member = Member.new(params[:member])
    if @member.save
      respond_to do |format|
        format.html {
          flash[:notice] = "Created member '#{@member.username}'"
          redirect_to(:action => 'show', :id => @member)
        }
      end
    else
      respond_to do |format|
        format.html { render :action => 'new', :status => :unprocessable_entity }
      end
    end
  end

  def update
    @member = Member.find(params[:id])

    respond_to do |format|
      if @member.update_attributes(params[:member])
        format.html { redirect_to(:action => 'show', :id => @member) }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy
    @member = Member.find(params[:id])
    @member.destroy

    respond_to do |format|
      format.html { redirect_to(admin_members_url) }
    end
  end
end

