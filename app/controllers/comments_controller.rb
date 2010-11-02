class CommentsController < ApplicationController

  def create
    @comment = Comment.new
		@comment.post_id = params[:comment][:post]
		@comment.user_id = params[:comment][:user]
		@comment.content = params[:comment][:content]

    respond_to do |format|
      if @comment.save
        format.html { redirect_to(params[:comment][:url],:notice => 'Comment was successfully created.') }
        format.xml  { render :xml => @comment, :status => :created, :location => @comment }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @comment.errors, :status => :unprocessable_entity }
      end
    end
  end
 
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to('/posts') }
      format.xml  { head :ok }
    end
  end
end
