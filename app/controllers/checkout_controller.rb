class CheckoutController < ApplicationController

  before_action :require_login

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
		@item.due_time = Time.now + @item.type.borrow_duration.hours
		@item.save
		redirect_to item_url(@item.id)
	end
  end

  def destroy

	@item = Item.find_by_barcode(params["barcode"])
	if !@item.nil?
		
		hours = ((Time.now - @item.due_time) / 1.hour).round
		
		if hours > 0
		  @user = User.find_by_id(@item.borrower_id)
		  fine_total = hours * @item.type.late_fee
		  
		  if fine_total > @item.category.replacement_cost
			fine_total = @item.category.replacement_cost
		  end
		  
		  @fine = Fine.new(created_on: Time.now, amount: fine_total, item_id: @item.id, paid: 0, user_id: @user.id)
		  @fine.save
		  flash[:notice] = "Item was returned late. #{@user.fullname} has been fined $#{fine_total}."
		end
		
		@item.status = "available"
		@item.borrower_id = nil
		@item.due_time = nil
		@item.save
		redirect_to item_url(@item.id)
    else
		flash[:notice] = "Invalid barcode."
		redirect_to "/checkout"
	end
		
  end
  
end