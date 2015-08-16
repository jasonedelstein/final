class NoteController < ApplicationController

# the sortable columns code is implemented as a cool side exercise based on the code here:
# http://railscasts.com/episodes/228-sortable-table-columns
# I don't consider it my own code, but implementing it for my own app was fun and useful. -JE 8.2.2015

  def new
    @note = Note.new
  end

  def create
	
    @note = Note.new
	@note.text = params["text"]
	@note.item_id = params["item_id"]
	@note.creator_id = session[:user_id]
	@note.created_on = Time.now.to_s(:db)
	@note.save
    
    if @note.save
      redirect_to "/item/#{params["item_id"]}"
    else
	  redirect_to "/item/#{params["item_id"]}/?fail=1"
    end
  end

  def destroy
    @note = Note.find_by(:id => params["id"])
    @note.delete
    redirect_to "/item/#{@note.item_id}"
  end
  
end