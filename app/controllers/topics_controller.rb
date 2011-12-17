class TopicsController < ApplicationController
  before_filter :authenticate, :only => [:new, :create, :edit, :update, :destroy]
  before_filter :correct_user, :only => [:edit, :update, :destroy]

  # GET /topics
  def index
    @topics = Topic.all

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /topics/1
  def show
    @forum = Forum.find(params[:forum_id])
    @topic = @forum.topics.find(params[:id])
    @posts = @topic.posts
    @title = @topic.title

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET /topics/new
  def new
    @topic = Topic.new
    @forum = Forum.find(params[:forum_id])

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /topics/1/edit
  def edit
    @forum = Forum.find(params[:forum_id])
    @topic = @forum.topics.find(params[:id])
    @title = @topic.title
  end

  # POST /topics
  def create
    @forum = Forum.find(params[:forum_id])
    @topic = Topic.new(params[:topic])

    @topic.user_id = current_user.id
    @topic.forum_id = @forum.id

    respond_to do |format|
      if @topic.save
        format.html { redirect_to(forum_topic_path(@forum,@topic), :notice => 'Topic was successfully created.') }
      else
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /topics/1
  def update
    @topic = Topic.find(params[:id])

    respond_to do |format|
      if @topic.update_attributes(params[:topic])
        format.html { redirect_to(@topic, :notice => 'Topic was successfully updated.') }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  # DELETE /topics/1
  def destroy
    @forum = Forum.find(params[:forum_id])
    @topic = Topic.find(params[:id])
    @topic.destroy

    respond_to do |format|
      format.html { redirect_to(@forum) }
    end
  end

  private

    def authenticate
      deny_access unless signed_in?
    end

    def correct_user
      @topic = Topic.find(params[:id])
      @user = User.find(@topic.user_id)
      redirect_to(root_path) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end
end
