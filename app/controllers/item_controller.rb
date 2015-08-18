class ItemController < ApplicationController

  autocomplete :item, :barcode

  def update
    @item = Item.find_by(:id => params["id"])
	@item.name = params["name"]
	@item.barcode = params["barcode"]
	@item.category_id = params["category_id"]
	@item.type_id = params["type_id"]
	@item.condition = params["condition"]
	@item.borrow_count = 0
	@item.status = params["status"]
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
	@item.condition = "new"
	@item.borrower_id = nil
	@item.borrow_count = 0
	@item.save
    
    if @item.save
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

	@items = Item.order(sort_column + " " + sort_direction)
    @items = @items.page(params[:page]).per(4)
	
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