class ForumsController < ApplicationController
  before_filter :authenticate, :only => [:new, :create, :edit, :update, :destroy]
  before_filter :correct_user, :only => [:edit, :update, :destroy]

  # GET /forums
  def index
    @forums = Forum.all
    @title  = "CINS 465: Forums with Rails"

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /forums/1
  def show
    @forum  = Forum.find(params[:id])
    @topics = @forum.topics
    @title  = @forum.title

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET /forums/new
  def new
    @forum = Forum.new
    @users = User.all
    @title = "Create new forum"

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /forums/1/edit
  def edit
    @forum = Forum.find(params[:id])
    @title = @forum.title
  end

  # POST /forums
  def create
    @forum = Forum.new(params[:forum])
    @forum.user_id = current_user.id

    respond_to do |format|
      if @forum.save
        format.html { redirect_to(@forum, :notice => 'Forum was successfully created.') }
      else
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /forums/1
  def update
    @forum = Forum.find(params[:id])

    respond_to do |format|
      if @forum.update_attributes(params[:forum])
        format.html { redirect_to(@forum, :notice => 'Forum was successfully updated.') }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  # DELETE /forums/1
  def destroy
    @forum = Forum.find(params[:id])
    @forum.destroy

    respond_to do |format|
      format.html { redirect_to(forums_url) }
    end
  end

  private

    def authenticate
      deny_access unless signed_in?
    end

    def correct_user
      @forum = Forum.find(params[:id])
      @user = User.where(:id => @forum.user_id)[0]
      redirect_to(root_path) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end
end
