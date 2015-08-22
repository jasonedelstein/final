class ItemController < ApplicationController

  before_action :set_search

  autocomplete :item, :barcode

  def set_search
	 @search_target = "item"
  end
  
  def update
    @item = Item.find_by(:id => params["id"])
	@item.name = params["name"]
	@item.barcode = params["barcode"]
	@item.category_id = params["category_id"]
	@item.type_id = params["type_id"]
	@item.condition = params["condition"]
	@item.borrow_count = 0
	@item.status = params["status"]
	
	if params[:accessory_id]
		@item.accessory_id = params[:accessory_id]
	end
	
	@item.save
    redirect_to root_url
  end

  def edit
    @item = Item.find_by(:id => params["id"])
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new
	@item.name = params["name"]
	@item.barcode = params["barcode"]
	@item.category_id = params["category_id"]
	@item.type_id = params["type_id"]
	@item.status = "available"
	@item.condition = "good"
	@item.borrower_id = nil
	@item.borrow_count = 0
	@item.creator_id = session[:user_id]
	@item.save
    
    if @item.save
	  flash[:notice] = "An item titled: #{@item.name} with barcode: #{@item.barcode} has been created successfully."
      redirect_to root_url
    else
      render 'new'
    end
  end

  def index
  if params["keyword"].present?
      k = params["keyword"].strip
      @items = Item.where("name LIKE ?", "%#{k}%")
    else
      @items = Item.all
    end
	
    @items = @items.page(params[:page]).per(4).order(:barcode)
	
    end

    respond_to do |format|
      format.html do
        render 'index'
      end
	  
      format.json do
        render :json => @items
      end
	  
      format.xml do
        render :xml => @items
      end
	  
    end

  def destroy
    @item = Item.find_by(:id => params["id"])
    @item.delete
    redirect_to root_url
  end

  def show
    @note = Note.new
    @item = Item.find_by(:id => params["id"])
  end
  
end