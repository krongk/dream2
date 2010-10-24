class NotesController < ApplicationController
  before_filter :login_required
  before_filter :load_couple

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
    @notes = Note.paginate :page => params[:page] || 1, :per_page => 8, :order => 'id DESC'  
		if params[:uid]
			if current_user.id != params[:uid].to_i
				@notes = Note.paginate :conditions=>['user_id = ?',@you.id], :page => params[:page] || 1, :per_page => 10, :order => 'id DESC'  
			else
				@notes = Note.paginate :conditions=>['user_id = ?',current_user.id], :page => params[:page] || 1, :per_page => 10, :order => 'id DESC' 
			end
		end
	  respond_to do |format|
      format.html # index.html.erb
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
	  
    respond_to do |format|
      if @note.save
        format.html { redirect_to(notes_path, :notice => 'Note was successfully created.') }
        format.xml  { render :xml => @note, :status => :created, :location => @note }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @note.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /notes/1
  # PUT /notes/1.xml
  def update
    @note = Note.find(params[:id])

    respond_to do |format|
			if @note.user_id == current_user.id || current_user.id == User.find_by_login('admin').id
					if @note.update_attributes(params[:note])
						format.html { redirect_to(notes_url, :notice => 'Note was successfully updated.') }
						format.xml  { head :ok }
					else
						format.html { render :action => "edit" }
						format.xml  { render :xml => @note.errors, :status => :unprocessable_entity }
					end
			else
				format.html { redirect_to(root_url, :notice => "No Permissions.") }
			end
    end
  end

  # DELETE /notes/1
  # DELETE /notes/1.xml
  def destroy
    @note = Note.find(params[:id])
		respond_to do |format|
			if @note.user_id == current_user.id || current_user.id == User.find_by_login('admin').id
				@note.destroy
				format.html { redirect_to(notes_url) }
				format.xml  { head :ok }
			else
				format.html {redirect_to(notes_url, :notice => "No Permissions.")}
				format.xml  { render :xml => @note.errors, :status => :unprocessable_entity }
			end
    end
  end

end