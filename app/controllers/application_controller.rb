class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  # the sortable columns code is implemented as a cool side exercise based on the code here:
# http://railscasts.com/episodes/228-sortable-table-columns
# I don't consider it my own code, but implementing it for my own app was fun and useful. -JE 8.2.2015

  helper_method :sort_column, :sort_direction
  
   def sort_column
    Note.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
  
  end
