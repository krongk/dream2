class PostsController < ApplicationController
  before_filter :login_required
  before_filter :load_couple
  #caches_action :index

  def load_couple
    User.find(2,3).each do |user|
       @you = user unless user.id == current_user.id
    end
		@you = User.find(1) if @you.nil?
  end
	# GET /posts
  # GET /posts.xml
  def index
    @posts = Post.order('id DESC').page(params[:page] || 1)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @posts }
    end
  end

  # GET /posts/1
  # GET /posts/1.xml
  def show
    @post = Post.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @post }
    end
  end

  # GET /posts/new
  # GET /posts/new.xml
  def new
    @post = Post.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @post }
    end
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
  end

  # POST /posts
  # POST /posts.xml
  def create
	  #expire_action :action => :index
    @post = Post.new(params[:post])
    
    respond_to do |format|
		  if @post.user_id == current_user.id
        if @post.save
					format.html { redirect_to(posts_url, :notice => 'Post was successfully created.') }
					format.xml  { render :xml => @post, :status => :created, :location => @post }
			  end
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.xml
  def update
	  #expire_action :action => :index
    @post = Post.find(params[:id])

    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to(posts_url, :notice => 'Post was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.xml
  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to(posts_url) }
      format.xml  { head :ok }
    end
  end
end
