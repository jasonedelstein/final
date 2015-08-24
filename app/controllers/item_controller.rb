class ItemController < ApplicationController

  before_action :set_search
  before_action :require_admin, except: [:index, :set_search, :show]

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
	@item.status = params["status"]
	
	Kit.delete_all(:item_id => @item.id)
	
	if params[:accessory_ids]
		@accessories = Accessory.find(params[:accessory_ids])
		
		@accessories.each do |a|
			@kit = Kit.new
			@kit.item_id = @item.id
			@kit.accessory_id = a.id
			@kit.save
		end
	end
	
	@item.save
    redirect_to root_url
  end

  def edit
	session[:return] ||= request.referrer
    @item = Item.find_by(:id => params["id"])
  end

  def new
    @item = Item.new
	@accessory = Accessory.new
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
			
		if params[:accessory_ids]
			ids = params[:accessory_ids]
			ids.each do |i|
				@kit = Kit.new
				@kit.item_id = @item.id
				@kit.accessory_id = i
				@kit.save
			end
		end
		
	  flash[:notice] = "An item titled: #{@item.name} with barcode: #{@item.barcode} has been created successfully."
      redirect_to item_url(@item.id)
    else
      render 'new'
    end
  end

  def index
  if params["keyword"].present?
      k = params["keyword"].strip.downcase
      @items = Item.where("LOWER(name) LIKE ?", "%#{k}%")
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
  
  def create_accessory
	@item = Item.new
	@accessory = Accessory.new
	@accessory.name = params[:name]
	@accessory.save
	
	if @accessory.save
		flash[:notice] = "A new accessory named #{@accessory.name} has been created."
		redirect_to new_item_url
	else
		render 'item/new'
    end
  end
end