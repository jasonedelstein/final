class NoteController < ApplicationController

# the sortable columns code is implemented as a cool side exercise based on the code here:
# http://railscasts.com/episodes/228-sortable-table-columns
# I don't consider it my own code, but implementing it for my own app was fun and useful. -JE 8.2.2015

	helper_method :sort_column, :sort_direction

  def new
    @note = Note.new
  end

  def create
    @note = Note.new
	@note.text = params["text"]
	@note.item_id = params["item_id"]
	@note.creator_id = User.first.id
	@note.created_on = Time.now.to_s(:db)
	@note.save
    
    if @note.save
      redirect_to "/item/#{params["item_id"]}"
    else
      render "/item/#{params["item_id"]}"
    end
  end

  def destroy
    @note = Note.find_by(:id => params["id"])
    @note.delete
    redirect_to "/item/#{@note.item_id}"
  end
  
  private
    
  def sort_column
    Note.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
  
end