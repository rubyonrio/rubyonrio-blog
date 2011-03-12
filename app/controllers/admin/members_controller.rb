class Admin::MembersController < Admin::BaseController
  before_filter :find_member, :only => [:show, :update, :destroy]

  def index
    respond_to do |format|
      format.html {
        @members = Member.paginate(
          :order => "created_at DESC",
          :page  => params[:page]
        )
      }
    end
  end

  def show
    respond_to do |format|
      format.html {
        render :partial => 'member', :locals => {:member => @member} if request.xhr?
      }
    end
  end

  def new
    @member = Member.new
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
    respond_to do |format|
      if @member.update_attributes(params[:member])
        flash[:notice] = 'Member updated successfully'
      else
        flash[:notice] = 'Invalid username'
      end
      format.html { redirect_to(:action => 'show', :id => @member) }
    end
  end

  def destroy
    undo_item = @member.destroy_with_undo

    respond_to do |format|
      format.html do
        flash[:notice] = "Member '#{@member.username}' deleted"
        redirect_to :action => 'index'
      end
      format.json {
        render :json => {
          :undo_path    => undo_admin_undo_item_path(undo_item),
          :undo_message => undo_item.description,
          :member         => @member.attributes
        }.to_json
      }
    end
  end

  protected

  def find_member
    @member = Member.find(params[:id])
  end
end

