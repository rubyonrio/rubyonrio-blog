class PostsController < ApplicationController
  def index
    @tag = params[:tag]
    @posts = Post.find_recent(:tag => @tag, :include => :tags)

    respond_to do |format|
      format.html
      format.atom { render :layout => false }
    end
  end

  def show
    @post = Post.find_by_permalink(*([:year, :month, :day, :slug].collect {|x| params[x] } << {:include => [:approved_comments, :tags]}))
    @comment = Comment.new
  end

  def old_slug
    @post = Post.where("old_slug like ?", '%'+params[:old_slug]+'%')[0]
    redirect_to post_path(:year => @post.published_at.year, :month => @post.published_at.month, :day => @post.published_at.day, :slug => @post.slug)
  end
end
