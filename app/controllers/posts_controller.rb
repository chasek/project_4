class PostsController < ApplicationController
  before_filter :authenticate, :only => [:new, :create, :edit, :update, :destroy]
  before_filter :correct_user, :only => [:edit, :update, :destroy]

  # GET /posts
  def index
    @posts = Post.all

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /posts/1
  def show
    @post = Post.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET /posts/new
  def new
    @forum = Forum.find(params[:forum_id])
    @topic = @forum.topics.find(params[:topic_id])
    @post = Post.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /posts/1/edit
  def edit
    @forum = Forum.find(params[:forum_id])
    @topic = @forum.topics.find(params[:topic_id])
    @post = @topic.posts.find(params[:id])
  end

  # POST /posts
  def create
    @forum = Forum.find(params[:forum_id])
    @topic = @forum.topics.find(params[:topic_id])
    @post = Post.new(params[:post])

    @post.user_id = current_user.id
    @post.topic_id = @topic.id

    respond_to do |format|
      if @post.save
        format.html { redirect_to(forum_topic_path(@forum,@topic), :notice => 'Post was successfully created.') }
      else
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /posts/1
  def update
    @forum = Forum.find(params[:forum_id])
    @topic = @forum.topics.find(params[:topic_id])
    @post = @topic.posts.find(params[:id])

    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to(forum_topic_path(@forum,@topic), :notice => 'Post was successfully updated.') }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  # DELETE /posts/1
  def destroy
    @forum = Forum.find(params[:forum_id])
    @topic = Topic.find(params[:topic_id])
    @post = Post.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to(forum_topic_path(@forum,@topic), :notice => 'Post was successfully deleted.') }
    end
  end

  private

    def authenticate
      deny_access unless signed_in?
    end

    def correct_user
      @post = Post.find(params[:id])
      @user = User.find(@post.user_id)
      redirect_to(root_path) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end

end
