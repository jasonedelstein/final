class CheckoutController < ApplicationController

  def index
    @item = Item.new
  end
  
  def create
  
	@item = Item.find_by_barcode(params["barcode"])
	
	if @item.nil?
		flash[:notice] = "Invalid item. Try again!"
		redirect_to "/checkout"
	elsif @item.borrowed?
		flash[:notice] = "#{@item.barcode} is already checked out to  #{@item.user.fullname}."
		redirect_to "/checkout"
	elsif @item.retired?
		flash[:notice] = "#{@item.barcode} is retired. It cannot be loaned."
		redirect_to "/checkout"
	elsif User.find_by_email(params["email"]).nil?
		flash[:notice] = "Invalid borrower email address."
		redirect_to "/checkout"
	else
		@item.status = "borrowed"
		@item.borrow_count = @item.borrow_count + 1
		@item.borrower_id = User.find_by_email(params["email"]).id
		@item.save
		redirect_to item_url(@item.id)
	end
  end

  def destroy

	@item = Item.find_by_barcode(params["barcode"])
	if !@item.nil?
		@item.status = "available"
		@item.borrower_id = nil
		@item.save
		redirect_to item_url(@item.id)
    else
		flash[:notice] = "Invalid barcode."
		redirect_to "/checkout"
	end
		
  end
  
end