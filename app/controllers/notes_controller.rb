class NotesController < ApplicationController
  before_filter :login_required
  before_filter :load_couple
  #caches_action :index

  def load_couple
    User.find(2,3).each do |user|
       @you = user unless user.id == current_user.id
    end
		@you = User.find(1) if @you.nil?
  end
  # GET /notes
  # GET /notes.xml
  def index
    @note = Note.new
    #@notes = Note.paginate(:page => params[:page] || 1, :per_page => 8)
    @notes = Note.page(params[:page] || 1)

		if params[:uid]  
			if current_user.id != params[:uid].to_i
				@notes = Note.paginate :conditions=>['user_id = ?',@you.id], :page => params[:page] || 1, :per_page => 10, :order => 'id DESC'  
			else
				@notes = Note.paginate :conditions=>['user_id = ?',current_user.id], :page => params[:page] || 1, :per_page => 10, :order => 'id DESC' 
			end
		end
	  respond_to do |format|
      format.html # index.html.erb
			format.mobile { render :mobile => 'index.mobile.erb'}
      format.xml  { render :xml => @notes }
    end
  end

  # GET /notes/1
  # GET /notes/1.xml
  def show
    @note = Note.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @note }
    end
  end

  # GET /notes/new
  # GET /notes/new.xml
  def new
    @note = Note.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @note }
    end
  end

  # GET /notes/1/edit
  def edit
    @note = Note.find(params[:id])
  end

  # POST /notes
  # POST /notes.xml
  def create
    @note = Note.new(params[:note])
	  if @note.user_id == current_user.id
			if @note.save
				 #redirect_to("/notes", :notice => 'Note was successfully created.') 
				 redirect_to "#{$SITE_URL}notes"
			end
    else
       render :action => "new" 
    end
  end

  # PUT /notes/1
  # PUT /notes/1.xml
  def update
	 #expire_action :action => :index
    @note = Note.find(params[:id])
			if @note.user_id == current_user.id || current_user.id == User.find_by_login('admin').id
					if @note.update_attributes(params[:note])
						redirect_to(notes_url, :notice => 'Note was successfully updated.') 
					else
						render :action => "edit" 
					end
			else
				redirect_to(root_url, :notice => "No Permissions.") 
			end
  end

  # DELETE /notes/1
  # DELETE /notes/1.xml
  def destroy
    @note = Note.find(params[:id])
			if @note.user_id == current_user.id || current_user.id == User.find_by_login('admin').id
				@note.destroy
				 redirect_to("/notes", :notice => "deleted.") 
			else
				redirect_to(notes_url, :notice => "No Permissions.")
			end
  end

end
